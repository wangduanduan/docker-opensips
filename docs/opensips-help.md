version: opensips 3.5.6 (x86_64/linux)
Usage: opensips -l address [-l address ...] [options]
Options:
    -f file      Configuration file (default /usr/local/etc/opensips/opensips.cfg)
    -c           Check configuration file for errors
    -C           Similar to '-c' but in addition checks the flags of exported
                  functions from included route blocks
    -l address   Listen on the specified address/interface (multiple -l
                  mean listening on more addresses).  The address format is
                  [proto:]addr[:port], where proto=udp|tcp and 
                  addr= host|ip_address|interface_name. E.g: -l locahost, 
                  -l udp:127.0.0.1:5080, -l eth0:5062 The default behavior
                  is to listen on all the interfaces.
    -n processes Number of worker processes to fork per UDP interface
                  (default: 8)
    -r           Use dns to check if is necessary to add a "received="
                  field to a via
    -R           Same as `-r` but use reverse dns;
                  (to use both use `-rR`)
    -v           Turn on "via:" host checking when forwarding replies
    -d           Debugging mode (multiple -d increase the level)
    -D           Run in debug mode
    -F           Daemon mode, but leave main process foreground
    -E           Option deprecated since version 3.4, set the 
                 "stderror_enabled=yes" configuration parameter instead
    -N processes Number of TCP worker processes (default: equal to `-n`)
    -W method    poll method
    -V           Version number
    -h           This help message
    -b nr        Maximum receive buffer size which will not be exceeded by
                  auto-probing procedure even if  OS allows
    -a allocator The memory allocator to use for all memory segments
                  Possible values: 
                      F_MALLOC    F_MALLOC_DBG
                      Q_MALLOC    Q_MALLOC_DBG
                      HP_MALLOC   HP_MALLOC_DBG
    -k allocator The pkg memory allocator to use (overrides -a)
    -s allocator The shared memory allocator to use (overrides -a)
    -e allocator The restart-persistent memory allocator to use (overrides -a)
    -m nr        Size of shared memory allocated in Megabytes
    -M nr        Size of pkg memory allocated in Megabytes
    -w dir       Change the working directory to "dir" (default "/")
    -t dir       Chroot to "dir"
    -u uid       Change uid 
    -g gid       Change gid 
    -p pp_cmd    Preprocess the configuration file (along with any others
                  included) using the specified system command. The command 
                  shall receive input via stdin and it must output the
                  result to stdout
    -P file      Create a pid file
    -G file      Create a pgid file
    -A address   Set the globally advertised addres