From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: uprobes enable condition (user space) - sysfs interface
Date: Mon, 4 Dec 2017 15:03:48 +0900
Message-ID: <20171204060348.GC16360@sejong>
References: <CA+bpL9+McSzeKW+eXHfMJMFRm-EenC9_0pGZkGpSdFzOVozKiw@mail.gmail.com>
 <20171201164039.GC3298@kernel.org>
 <CA+bpL9L3OYjEU5OUEnFQQSncpaVLM+3+h-rV9_gMa2F9xQRfWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        linux-rt-users@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>, kernel-team@lge.com
To: bhargavb <bhargavaramudu@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:41045 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752802AbdLDGDv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Dec 2017 01:03:51 -0500
Content-Disposition: inline
In-Reply-To: <CA+bpL9L3OYjEU5OUEnFQQSncpaVLM+3+h-rV9_gMa2F9xQRfWA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

On Sun, Dec 03, 2017 at 10:44:22PM +0530, bhargavb wrote:
> Dear Arnaldo,
> Exactly, the last one was what I was looking for. Thank you very much...
> That apart I am also exploring various profiling options that can give
> me a full control of monitoring running processes (user space
> profiling ).
> sysfs seems powerful and very useful, though I got to know lately (and
> not much mentioned, I think as tools like perf etc).  I was confused
> when u said tracefs in your response, I understand it is same as
> sysfs. Please correct me if I am wrong.

It's a different filesystem for controlling tracing features but just
happens to be mounted on top of a sysfs (or debugfs) directory.

  $ mount | grep tracefs
  tracefs on /sys/kernel/debug/tracing type tracefs (rw,relatime)


Also, writing to the 'enable' file changes state of every events in
that directory and its subdirectory.  So $TRACEFS/events/enable
changes all events.

Thanks,
Namhyung


> 
> 
> On Fri, Dec 1, 2017 at 10:10 PM, Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> > Adding Masami to the CC list, to see if he can come up with a fix for
> > the 'perf probe' failure below, improving the message or ignoring
> > versioned symbols (with a warning perhaps).
> >
> > Em Thu, Nov 30, 2017 at 12:04:23AM +0530, bhargavb escreveu:
> >> Hello,
> >>
> >> I am trying to understand user space profiling using linux inbuilt
> >> mechanism. (Trying with perf also but could not get complete clear
> >> documentation and could not proceed, so retained linux-perf-users in
> >> to list as the underlying interface used is same for both).
> >
> > So yo uwant to trace function entry/exit in some userspace library? You
> > can try using the tracefs as below or leave it to perf to do that, first
> > you set up the probes, say for some glibc functions:
> >
> > [root@jouet ~]# perf probe -F -x /lib64/libc-2.25.so  | grep ^malloc
> > malloc
> > malloc_check
> > malloc_consolidate.part.1
> > malloc_get_state@GLIBC_2.2.5
> > malloc_hook_ini
> > malloc_info
> > malloc_printerr
> > malloc_set_state@GLIBC_2.2.5
> > malloc_stats
> > malloc_trim
> > malloc_usable_size
> > mallochook
> > [root@jouet ~]#
> >
> > [root@jouet ~]# perf probe -x /lib64/libc-2.25.so malloc*
> > Failed to write event: Invalid argument
> >   Error: Failed to add events.
> > [root@jouet ~]#
> >
> > For now ignore that error, its a bug I just found, what matters is that
> > it _has_ put in place probes for most of those functions, as you can see
> > by looking at:
> >
> > [root@jouet ~]# perf probe -l
> >   probe_libc:malloc    (on __malloc in /usr/lib64/libc-2.25.so)
> >   probe_libc:malloc_check (on malloc_check in /usr/lib64/libc-2.25.so)
> >   probe_libc:malloc_consolidate (on malloc_consolidate.part.1 in /usr/lib64/libc-2.25.so)
> >   probe_libc:malloc_hook_ini (on malloc_hook_ini in /usr/lib64/libc-2.25.so)
> >   probe_libc:malloc_info (on __malloc_info in /usr/lib64/libc-2.25.so)
> >   probe_libc:malloc_printerr (on malloc_printerr in /usr/lib64/libc-2.25.so)
> >   probe_libc:malloc_stats (on __malloc_stats in /usr/lib64/libc-2.25.so)
> >   probe_libc:malloc_trim (on __malloc_trim in /usr/lib64/libc-2.25.so)
> >   probe_libc:malloc_usable_size (on __malloc_usable_size in /usr/lib64/libc-2.25.so)
> >   probe_libc:mallochook (on mallochook in /usr/lib64/libc-2.25.so)
> > [root@jouet ~]#
> >
> > Masami, this one also doesn't work:
> >
> > [root@jouet ~]# perf probe -x /lib64/libc-2.25.so 'malloc*%return'
> > Error: event "malloc_printerr" already exists.
> > <SNIP>
> >
> > doing it a bit differently:
> >
> > [root@jouet ~]# perf probe -F -x /lib64/libc-2.25.so | egrep ^malloc[^@]+$ | while read function ; do perf probe -x /lib64/libc-2.25.so "${function}_return=$function%return" ; done
> > Added new event:
> >   probe_libc:malloc_check_return (on malloc_check%return in /usr/lib64/libc-2.25.so)
> >
> > You can now use it in all perf tools, such as:
> >
> >         perf record -e probe_libc:malloc_check_return -aR sleep 1
> >
> > <SNIP>
> > -----------
> >
> > This now makes us have:
> >
> > [root@jouet ~]# perf probe -l
> >   probe:check_stack_object (on check_stack_object%return@acme/git/linux/mm/usercopy.c with ret)
> >   probe_libc:malloc    (on __malloc in /usr/lib64/libc-2.25.so)
> >   probe_libc:malloc_check (on malloc_check in /usr/lib64/libc-2.25.so)
> >   probe_libc:malloc_consolidate (on malloc_consolidate.part.1 in /usr/lib64/libc-2.25.so)
> >   probe_libc:malloc_hook_ini (on malloc_hook_ini in /usr/lib64/libc-2.25.so)
> >   probe_libc:malloc_info (on __malloc_info in /usr/lib64/libc-2.25.so)
> >   probe_libc:malloc_printerr (on malloc_printerr in /usr/lib64/libc-2.25.so)
> >   probe_libc:malloc_stats (on __malloc_stats in /usr/lib64/libc-2.25.so)
> >   probe_libc:malloc_trim (on __malloc_trim in /usr/lib64/libc-2.25.so)
> >   probe_libc:malloc_usable_size (on __malloc_usable_size in /usr/lib64/libc-2.25.so)
> >   probe_libc:mallochook (on mallochook in /usr/lib64/libc-2.25.so)
> >   probe_libc:malloc_check_return (on malloc_check%return in /usr/lib64/libc-2.25.so)
> >   probe_libc:malloc_hook_ini_return (on malloc_hook_ini%return in /usr/lib64/libc-2.25.so)
> >   probe_libc:malloc_info_return (on __malloc_info%return in /usr/lib64/libc-2.25.so)
> >   probe_libc:malloc_printerr_return (on malloc_printerr%return in /usr/lib64/libc-2.25.so)
> >   probe_libc:malloc_stats_return (on __malloc_stats%return in /usr/lib64/libc-2.25.so)
> >   probe_libc:malloc_trim_return (on __malloc_trim%return in /usr/lib64/libc-2.25.so)
> >   probe_libc:malloc_usable_size_return (on __malloc_usable_size%return in /usr/lib64/libc-2.25.so)
> >   probe_libc:mallochook_return (on mallochook%return in /usr/lib64/libc-2.25.so)
> >   probe_libc:malloc_return (on __malloc%return in /usr/lib64/libc-2.25.so)
> > [root@jouet ~]#
> >
> > There were some usability snags that prevented this from being put in
> > place, so do it manually:
> >
> > [root@jouet ~]# perf probe -x /lib64/libc-2.25.so 'malloc_consolidate_return=malloc_consolidate.part.1%return'
> > Added new event:
> >   probe_libc:malloc_consolidate_return (on malloc_consolidate.part.1%return in /usr/lib64/libc-2.25.so)
> >
> > You can now use it in all perf tools, such as:
> >
> >         perf record -e probe_libc:malloc_consolidate_return -aR sleep 1
> >
> > [root@jouet ~]#
> >
> > Ok, now we can trace this syswide using:
> >
> > [root@jouet ~]# perf trace --no-syscalls -e probe_libc:*
> > <BIG SNIP>
> >    339.557 probe_libc:malloc:(7fda55c22970))
> >    339.562 probe_libc:malloc_return:(7fda55c22970 <- 7fda55c23918))
> >    339.567 probe_libc:malloc_consolidate:(7fda55c1b7b0))
> >    339.570 probe_libc:malloc_consolidate_return:(7fda55c1b7b0 <- 7fda55c1f886))
> >    339.596 probe_libc:malloc:(7fda55c22970))
> >    339.600 probe_libc:malloc_return:(7fda55c22970 <- 7fda55c23918))
> >    339.622 probe_libc:malloc:(7fda55c22970))
> >    339.626 probe_libc:malloc_return:(7fda55c22970 <- 7fda56ba9a39))
> >    339.631 probe_libc:malloc:(7fda55c22970))
> >    339.634 probe_libc:malloc_return:(7fda55c22970 <- 7fda578f1713))
> >    339.637 probe_libc:malloc:(7fda55c22970))
> >    339.641 probe_libc:malloc_return:(7fda55c22970 <- 7fda578f14ae))
> >    339.657 probe_libc:malloc_consolidate:(7fda55c1b7b0))
> >    339.661 probe_libc:malloc_consolidate_return:(7fda55c1b7b0 <- 7fda55c1dbd6))
> >    339.664 probe_libc:malloc:(7fda55c22970))
> >    339.667 probe_libc:malloc_return:(7fda55c22970 <- 7fda55c23918))
> >    339.670 probe_libc:malloc:(7fda55c22970))
> >    339.673 probe_libc:malloc_return:(7fda55c22970 <- 7fda55c23918))
> >    339.678 probe_libc:malloc_consolidate:(7fda55c1b7b0))
> >    339.681 probe_libc:malloc_consolidate_return:(7fda55c1b7b0 <- 7fda55c1f886))
> >    339.685 probe_libc:malloc_consolidate:(7fda55c1b7b0))
> >    339.688 probe_libc:malloc_consolidate_return:(7fda55c1b7b0 <- 7fda55c1f886))
> >    339.693 probe_libc:malloc_consolidate:(7fda55c1b7b0))
> >    339.696 probe_libc:malloc_consolidate_return:(7fda55c1b7b0 <- 7fda55c1f886))
> >    339.778 probe_libc:malloc:(7fda55c22970))
> >    339.783 probe_libc:malloc_return:(7fda55c22970 <- 7fda55c23918))
> >    339.788 probe_libc:malloc_consolidate:(7fda55c1b7b0))
> >   ^C(7fda55c22970 <- 7fda578f14ae))
> > [root@jouet ~]#
> >
> > It works as well with 'perf record' + 'perf script'.
> >
> > Other features from perf can be added to the mix, like callchains, etc.
> >
> > But see below for doing it via tracefs
> >
> >> I observed below behaviour when I tried as per directions using URL:
> >> https://opensource.com/article/17/7/dynamic-tracing-linux-user-and-kernel-space#comment-136366
> >> :
> >>
> >>
> >> echo 'p:<func_entry> ./test:0x420' >
> >> /sys/kernel/debug/tracing/uprobe_events              (for creating
> >> uprobe)
> >> echo 1 > /sys/kernel/debug/tracing/events/enable
> >>                                 (enabling uproble)
> >> There is another enable parameter:
> >> /sys/kernel/debug/tracing/events/uprobes/enable
> >>
> >> I understand unless enabled both events/enable and
> >> events/uprobes/enable, the /sys/kernel/debug/tracing/trace is not
> >> complete. I do not understand the relevance of
> >> .....events/uprobes/enable as I could not get any trace data in trace
> >> log for 'func_entry' the user space function being added for tracing.
> >> Irrespective of the probe function added, the trace log shows complete
> >> system trace log during the period of execution of the user
> >> application being traced.
> >
> > Is this what you want:
> >
> > [root@jouet ~]# cd /sys/kernel/debug/tracing/
> > [root@jouet tracing]# cat available_tracers
> > hwlat blk mmiotrace function_graph wakeup_dl wakeup_rt wakeup function nop
> > [root@jouet tracing]# echo nop > current_tracer
> > [root@jouet tracing]# echo 1 > events/probe_libc/malloc/enable
> > [root@jouet tracing]# echo 1 > tracing_on
> > [root@jouet tracing]# tail trace
> >             tail-1581  [002] d... 118484.507167: malloc: (0x7fdb32d67970)
> >             tail-1581  [002] d... 118484.507172: malloc: (0x7fdb32d67970)
> >             tail-1581  [002] d... 118484.507189: malloc: (0x7fdb32d67970)
> >             tail-1581  [002] d... 118484.507193: malloc: (0x7fdb32d67970)
> >             tail-1581  [002] d... 118484.507198: malloc: (0x7fdb32d67970)
> >             tail-1581  [002] d... 118484.507203: malloc: (0x7fdb32d67970)
> >             tail-1581  [002] d... 118484.507208: malloc: (0x7fdb32d67970)
> >             tail-1581  [002] d... 118484.507214: malloc: (0x7fdb32d67970)
> >             tail-1581  [002] d... 118484.507224: malloc: (0x7fdb32d67970)
> >             tail-1581  [002] d... 118484.507237: malloc: (0x7fdb32d67970)
> > [root@jouet tracing]#
> >
> > ?
> >
> >> Can this be clearly mentioned as to when to use one of them, role of
> >> both and and also, I could not see uprobe function in particular at
> >> all but generic trace in /sys/kernel/debug/tracing/trace. Kindly guide
> >> me in understanding uprobe enable logic in user space in detail.
> >>
> >> Regards,
> >> Bhargav
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> -- 
> Bhargav
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
