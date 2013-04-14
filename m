From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: [ANNOUNCE] 3.6.11.1-rt32
Date: Sun, 14 Apr 2013 23:13:29 +0200
Message-ID: <516B1BF9.3000002@osadl.org>
References: <1364527527.10629.10.camel@gandalf.local.home>  <515A4CE4.9050607@osadl.org> <1365529616.25498.75.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1365529616.25498.75.camel@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Steven,

>>> I'm pleased to announce the 3.6.11.1-rt32 stable release.
>> Unfortunately, there is another compile error:
>> drivers/gpu/drm/i915/i915_gem.c: In function =E2=80=98i915_gem_wait_=
for_error=E2=80=99:
>> drivers/gpu/drm/i915/i915_gem.c:118:3: warning: passing argument 1 o=
f
>> =E2=80=98rt_spin_lock=E2=80=99 from incompatible pointer type [enabl=
ed by default]
>> In file included from include/linux/spinlock.h:273:0,
>>                    from include/linux/wait.h:24,
>>                    from include/linux/fs.h:396,
>>                    from include/drm/drmP.h:47,
>>                    from drivers/gpu/drm/i915/i915_gem.c:28:
>> [..]
>> I would propose to adopt the mechanism that Sebastian introduced in
>> 3.8.4-rt2 (https://lkml.org/lkml/2013/3/26/600). The kernel compiles
>> and runs without any problem with the below patch on a system that
>> requires the i915 driver module.
> Thanks Carsten, I'll be updating this later today.
Thank you.

> BTW, did you get any core dumps from the work queue race that we've
> been seeing?
No, not yet. Originally, the farm systems did not use crashkernels by
default. I understood that it does no harm but could help in cases like
this one. Therefore, I've started to reconfigure all farm system with
crashkernels - starting with the two systems that had the work queue
race crashes. The kernel messages here (one is a 12-core, the other one
a 32-core box) look exactly like the one=20
(https://lkml.org/lkml/2013/3/18/325)
you saw in your 40-core machine (https://lkml.org/lkml/2013/3/18/430).
We'll need to wait for the next crash that will give us a core dump we
may then dissect.

	-Carsten.
