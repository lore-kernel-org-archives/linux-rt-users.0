From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: Latency Problems with 2.6.31/PREEMPT_RT on a 1.2GHz Celeron
Date: Mon, 21 Dec 2009 21:36:58 +0100
Message-ID: <4B2FDC6A.4020205@osadl.org>
References: <abe060d60912171537j10fe194r5f0cd1aca85475df@mail.gmail.com> <4B2BB45A.9040909@mantatest.com> <4B2CBA28.1030405@cfl.rr.com> <200912211216.20588@zigzag.lvk.cs.msu.su> <4B2F4881.1070203@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nikita V. Youshchenko" <yoush@cs.msu.su>,
	Vladimir Cotfas <vladc@mantatest.com>,
	linux-rt-users@vger.kernel.org,
	Scott Gilbertson <scottg@mantatest.com>
To: dmarkh@cfl.rr.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:34743 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756971AbZLUUkQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Dec 2009 15:40:16 -0500
In-Reply-To: <4B2F4881.1070203@cfl.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/21/2009 11:05 AM, Mark Hounschell wrote:
> On 12/21/2009 04:16 AM, Nikita V. Youshchenko wrote:
>>> On 12/18/2009 11:56 AM, Vladimir Cotfas wrote:
>>>> I have a a driver that must process an interrupt every 100 uS without
>>>> missing any. I am having latency issues and I am looking for some help
>>>> debugging my problem.
>>> [..]
The question is whether the latencies you are seeing are avoidable or
unavoidable. Avoidable latencies are caused, among others, by an
inappropriate IRQ design, by inappropriate priority settings and, at
least theoretically, by suboptimally written code sections of the Linux
kernel.

Unavoidable latencies are caused by inappropriate hardware (including
the BIOS).

In order to differentiate between avoidable and unavoidable latencies,
you need to locate the source of the latencies. This is done using
function tracing which is stopped when a particular latency threshold is
exceeded. Function tracing can be enabled manually
  echo function >/sys/kernel/debug/tracing/current_tracer
and stopped when a high latency was detected from shell level
  echo 0 >/sys/kernel/debug/tracing/tracing_enabled
or from program level
  fd = open("/sys/kernel/debug/tracing/tracing_enabled"), O_WRONLY);
  if (high_latency_detected)
    write(fd, "0", 1);
For details, please refer to Steven Rostedt's
Documentation/trace/ftrace.txt.

Alternatively, the program cyclictest can be used. It is available in
the rt-tests package ("git clone
git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git").
When run with the -f and the -b <latency> option, cyclictest will enable
function tracing when started and stop function tracing, when the
latency specified in the -b option is exceeded. Function tracing will
slow down the system - and increase the latency - by a factor 3 to 5.
Fortunately, this will also increase the duration of the increased
latency we are searching, but we need to consider this when selecting
the argument to the -b option.

In a subsequent step, the trace is saved
  cat /sys/kernel/debug/tracing/trace >/tmp/trace.txt
and inspected. We need to draw special attention to the functions and
the time stamps of the functions that are called between our trigger and
the function that was executed later than we had hoped.

Such measurements have to be repeated several times. If the latency
always occurs in the same couple of functions, we are done. The source
of latency was located, and we (or someone else) may check whether there
is unused potential to speed up the execution of these functions.

In some cases, however, the latencies occur at random - irregularly at
very different places in kernel or driver code. This is highly
suspicious of SMIs (system management interrupts). The hwlatdetect
program that is also part of the rt-tests package should then be used, e.g.
# hwlatdetect
hwlatdetect:  test duration 120 seconds
   parameters:
        Latency threshold: 10us
        Sample window:     1000000us
        Sample width:      500000us
     Non-sampling period:  500000us
        Output File:       None

Starting test
test finished
Max Latency: 484us
Samples recorded: 120
Samples exceeding threshold: 120
1261425094.0352000690	476
1261425095.0355000511	455
1261425096.0358000767	467
1261425097.0362000529	467
1261425098.0365000756	467
1261425099.0368000765	466
1261425100.0371000817	466
1261425101.0373000745	468
1261425102.0377000509	467
1261425103.0380000862	466
1261425104.0382000591	466
etc.
In this case, one may try to play around with the BIOS settings (e.g.
power management, USB/serial mouse/keyboard emulation etc.). If this
does not help, the Linux kernel can help neither.

A normal result of hwlatdetect would look like
# hwlatdetect
hwlatdetect:  test duration 120 seconds
   parameters:
        Latency threshold: 10us
        Sample window:     1000000us
        Sample width:      500000us
     Non-sampling period:  500000us
        Output File:       None

Starting test
test finished
Max Latency: 0us
Samples recorded: 0
Samples exceeding threshold: 0

OSADL has created the email address latency-fighters@osadl.org (see
http://www.osadl.org/Realtime-Preempt-Kernel.kernel-rt.0.html) in the
hope that people are sending traces helping us to locate suboptimally
written code sections of the Linux kernel and, thus, to improve the
real-time capabilities of the PREEMPT_RT Linux kernel. Unfortunately,
only 1 out of 18 submissions of the last two years could be used to
improve the kernel. In all other cases, our only recommendation was to
get another computer board...

	Carsten.
