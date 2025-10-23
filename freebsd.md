+++
title = "baby steps to a wifi tool for FreeBSD ;)"
date = 2025-04-13
draft = false

[taxonomies]
tags = ["freebsd", "wifi", "networking"]
+++
![](https://freebsdfoundation.org/wp-content/uploads/2022/04/Untitled-design-8-1024x512.png)
So, I have been planning a WiFi management tool for FreeBSD for some time now. If you are on Linux, you have an array of tools to manage WiFi connections, but you won't be that lucky on FreeBSD :/

The first step to control WiFi connections is to control the Network Interface. Now, my first thought was to simply use `popen("ifconfig wlan0 up")`, but what if there's no wlan0? Say you have multiple WiFi drivers, Intel wireless cards (iwnX), etc. Also, it's bad design to do such a thing.

So the next best thing is to use `libifconfig`... But libifconfig has its own problems: it's not standard. At least my version of FreeBSD doesn't have it. Added to that, libifconfig is a fairly new tool and lacks good docuimentation. So probably the best thing to do now is make direct system calls to dynamically choose the right network interface. Once a valid network interface is found, we can move further.

A good resource to learn more on implementing such functionality is [this thread](https://stackoverflow.com/questions/23577787/how-can-i-enumerate-the-list-of-network-devices-or-interfaces-in-c-or-c-in-fre) on stackoverflow and the [getifaddrs() man page](https://man.freebsd.org/cgi/man.cgi?query=getifaddrs&sektion=3&manpath=freebsd-release-ports).

The following is a prototype function for finding WiFi interfaces for a FreeBSD system:

```c
char* find_wifi_interface() {
    struct ifaddrs *interfaces, *interface;
    struct ifmediareq media_request;
    int socket_fd;
    char *wifi_interface = NULL;
    getifaddrs(&interfaces);
    socket_fd = socket(AF_INET, SOCK_DGRAM, 0);
    if (socket_fd < 0) {
        freeifaddrs(interfaces);
        return NULL;
    }
    
    printf("Scanning interfaces:\n");
    
    for (interface = interfaces; interface != NULL; interface = interface->ifa_next) {
        if (!interface->ifa_name)
            continue;
        memset(&media_request, 0, sizeof(media_request));
        strncpy(media_request.ifm_name, interface->ifa_name, IFNAMSIZ - 1);
        
        if (ioctl(socket_fd, SIOCGIFMEDIA, (caddr_t)&media_request) == 0 && 
            (media_request.ifm_active & IFM_NMASK) == IFM_IEEE80211) {
            
            printf("  %s: WiFi interface\n", interface->ifa_name);
            wifi_interface = strdup(interface->ifa_name);  // Save the first Wi-Fi interface
            break;
        }
    }
    freeifaddrs(interfaces);
    close(socket_fd);
    return wifi_interface;
}
```
This C snippet creates a socket for system calls, gets a list of all network interfaces as a linked list, and then iterates through each interface. It uses the `ioctl()` system call with `SIOCGIFMEDIA` to check if each interface supports WiFi (specifically looking for the `IFM_IEEE80211` flag). The function prints diagnostic information to stderr during the search and returns the name of the first WiFi interface found (as a dynamically allocated string) or NULL if none is found.

Obviously, `<sys/types.h>` and `<ifaddrs.h>` for interface address structures, `<sys/socket.h>` for socket operations, `<sys/ioctl.h>` for the ioctl call, `<net/if.h>` for interface definitions, `<net/if_media.h>` for media information structures etc. would be needed.

Now once the Network interface is found, this can be stored as the default Wifi Interface and maybe changed if needed. Following function provides the functionality to toggle the interface on or off or provide Wifi Interface status.

```c
int toggle_wifi(const char *interface_name, int enable) {
    struct ifreq ifr;
    int socket_fd;
    int current_flags;
    int result = -1;
    if (!interface_name)
        return -1;
    socket_fd = socket(AF_INET, SOCK_DGRAM, 0);
    if (socket_fd < 0)
        return -1;
    
    memset(&ifr, 0, sizeof(ifr));
    strncpy(ifr.ifr_name, interface_name, IFNAMSIZ - 1);
    
    if (ioctl(socket_fd, SIOCGIFFLAGS, &ifr) < 0) {
        close(socket_fd);
        return -1;
    }
    
    current_flags = ifr.ifr_flags;
    
    if (enable == 1) {
        ifr.ifr_flags |= IFF_UP;
        if (ioctl(socket_fd, SIOCSIFFLAGS, &ifr) < 0) {
            close(socket_fd);
            return -1;
        }
        result = 1;
    } 
    else if (enable == 0) {
        ifr.ifr_flags &= ~IFF_UP;
        if (ioctl(socket_fd, SIOCSIFFLAGS, &ifr) < 0) {
            close(socket_fd);
            return -1;
        }
        result = 0;
    }
    else {
        // Just return current status (enable == -1)
        result = (current_flags & IFF_UP) ? 1 : 0;
    }
    close(socket_fd);
    return result;
}
```
The next step now is to allow for Scanning of Wifi Networks...
