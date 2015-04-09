From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: [PATCH] hwlat_detector: Detect hardware-induced latencies
Date: Thu, 9 Apr 2015 11:25:34 +0200
Message-ID: <5526458E.5050202@bmw-carit.de>
References: <1428508021-28166-1-git-send-email-daniel.wagner@bmw-carit.de> <20150408123550.7dbd61b4@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: <linux-rt-users@vger.kernel.org>, Jon Masters <jcm@redhat.com>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	<linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150408123550.7dbd61b4@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Steven,

On 04/08/2015 06:35 PM, Steven Rostedt wrote:
> On Wed, 08 Apr 2015 12:28:34 -0400
>> Hi,
>>
>> Here is my attempt to rewritte hwlat_detector. Most of the code is a
>> new except the detection routine itself. With some luck I didn't break
>> it.  I hope I updated the documentation correctly and also added all
>> the credits.
>>
>> @Carsten, I haven't found your original post of the hwlatdetect.patch
>> patch. I assume you have written most of the documentation. I guess
>> should be also added as copyright holder.
>>
> 
> Funny you are working on this. I'm actually working on porting the
> hwlat_detector to ftrace as a tracer and removing it as a module. It
> will be similar to the irqsoff tracer, although it wont be doing
> "latency" tests. It will just report the output to the ring buffer as
> the other tracers do.

Good to know. So best thing is to let this patch rest :) If need help
(e.g. testing) just let me know.

BTW, are you also taking care of the latency-hist.patch patch?

cheers,
daniel
