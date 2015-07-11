From: Beethovenklc <beethovenklc@gmail.com>
Subject: Error using cyclictest's tracing
Date: Sat, 11 Jul 2015 00:57:51 -0300
Message-ID: <mnq480$9ap$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:41060 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751602AbbGKHAO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 11 Jul 2015 03:00:14 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1ZDlxK-0003u4-K1
	for linux-rt-users@vger.kernel.org; Sat, 11 Jul 2015 06:00:03 +0200
Received: from 71-205-16-190.fibertel.com.ar ([190.16.205.71])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Sat, 11 Jul 2015 06:00:02 +0200
Received: from beethovenklc by 71-205-16-190.fibertel.com.ar with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Sat, 11 Jul 2015 06:00:02 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello.

This is my first time posting in this newsgroup, here from Argentina :D

I'm trying to sort out some latency problems on a system with Ubuntu 
14.04 LTS, kernel version 3.14.39-rt37 with rt-preempt patch and tracers 
enabled and AMD A10-6800K with 4 core of 4GHz CPU.

I'm having problems using cyclictest with -t flag to have more 
information regarding unpredictable latency peaks, but it shows an error.

$ sudo ./cyclictest -n -p99 -b200
# /dev/cpu_dma_latency set to 0us
INFO: debugfs mountpoint: /sys/kernel/debug/tracing/
WARN: tracing_enabled or tracing_on not found
debug fs not mounted, TRACERs not configured?
could not set ftrace_enabled to 0
FATAL: Can't open /sys/kernel/debug/tracing/available_tracers for reading


When I list "/sys/kernel/debug" I get


sudo ls /sys/kernel/debug/
acpi	    dma_buf	   frontswap  kvm-guest  regulator	 virtio-ports
bdi	    dri		   gpio       mce	 sched_features  wakeup_sources
bluetooth   dynamic_debug  hid	      pinctrl	 sleep_time	 x86
cleancache  eeepc-wmi	   kprobes    pwm	 suspend_stats
clk	    extfrag	   kvm	      regmap	 usb


It seems "tracing" folder is not present.. I've read that this folder is 
created when you use ftrace. Kernel was compiled with ftrace and tracers 
as you can see in my kernel .config file:


$ cat .config | grep _FTRACE
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set


$ cat .config | grep _TRACE
# CONFIG_TREE_RCU_TRACE is not set
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_TRACEPOINTS=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_NETFILTER_XT_TARGET_TRACE=m
# CONFIG_SCSI_IPR_TRACE is not set
# CONFIG_VXGE_DEBUG_TRACE_ALL is not set
# CONFIG_ATH5K_TRACER is not set
CONFIG_CAPI_TRACE=y
CONFIG_TRACE_ROUTER=m
CONFIG_TRACE_SINK=m
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS=y
# CONFIG_RCU_TRACE is not set
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_GENERIC_TRACER=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_IRQSOFF_TRACER=y
CONFIG_PREEMPT_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_STACK_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y


Did I miss something?

Thanks!

