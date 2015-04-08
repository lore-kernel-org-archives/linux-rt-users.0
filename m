From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] hwlat_detector: Detect hardware-induced latencies
Date: Wed, 8 Apr 2015 12:35:50 -0400
Message-ID: <20150408123550.7dbd61b4@gandalf.local.home>
References: <1428508021-28166-1-git-send-email-daniel.wagner@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, Jon Masters <jcm@redhat.com>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Mike Galbraith <bitbucket@online.de>,
	linux-kernel@vger.kernel.org
To: Daniel Wagner <daniel.wagner@bmw-carit.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428508021-28166-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 08 Apr 2015 12:28:34 -0400
Daniel Wagner <daniel.wagner@bmw-carit.de> wrote:

> A simple hardware latency detector. Use this module to detect large
> latencies introduced by the behavior of the underlying system firmware
> external to Linux. The hardware latency detector works by disabling
> interrupts while running a tight loop taking timestams and measure for
> unexplainable gaps in the CPU timestamp counter(s). Any gap indicates
> a time when the polling was interrupted and interrupts turned off the
> only thing that could do that would be an SMI.
> 
> By default, the module is not enabled until the "enable" file within
> the "hwlat_detector" debugfs directory is toggled.
> 
> Jon Masters developed this wonderful SMI detector. For details please
> consult Documentation/hwlat_detector.txt.
> 
> [dw: rewrote everything except the detector itself (sample_get()]
> 
> Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
> Cc: Jon Masters <jcm@redhat.com>
> Cc: Carsten Emde <C.Emde@osadl.org>
> Cc: Steven Rostedt <srostedt@redhat.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Mike Galbraith <bitbucket@online.de>
> Cc: linux-kernel@vger.kernel.org
> Cc; linux-rt-users@vger.kernel.org
> 
> Link: http://www.spinics.net/lists/linux-rt-users/msg10350.html
> ---
> Hi,
> 
> Here is my attempt to rewritte hwlat_detector. Most of the code is a
> new except the detection routine itself. With some luck I didn't break
> it.  I hope I updated the documentation correctly and also added all
> the credits.
> 
> @Carsten, I haven't found your original post of the hwlatdetect.patch
> patch. I assume you have written most of the documentation. I guess
> should be also added as copyright holder.
> 

Funny you are working on this. I'm actually working on porting the
hwlat_detector to ftrace as a tracer and removing it as a module. It
will be similar to the irqsoff tracer, although it wont be doing
"latency" tests. It will just report the output to the ring buffer as
the other tracers do.

-- Steve
