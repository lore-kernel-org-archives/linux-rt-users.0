From: Daniel Wagner <wagi@monom.org>
Subject: Re: [ANNOUNCE] 4.0.4-rt1
Date: Wed, 20 May 2015 15:18:31 +0200
Message-ID: <555C89A7.2010000@monom.org>
References: <20150519213923.GA26363@linutronix.de> <555BBA52.9030809@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <555BBA52.9030809@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 05/20/2015 12:33 AM, Carsten Emde wrote:
>> I'm pleased to announce the v4.0.4-rt1 patch set.
> First smoke test on an Intel Gulftown 980X: Compiled and booted without
> problem, no regression of real-time capabilities so far.
> 
>> [..]
>> Known issues:
>>        - My AMD box throws a lot of "cpufreq_stat_notifier_trans: No
>>          policy found" warnings after boot. It is gone after manually
>>          setting the policy (to something else than reported).
> Same here, probably a minor issue. The messages disappear after setting
> cpufreq to performance, but they reappear when setting cpufreq back to
> ondemand.
> 
> On a side note: We need teach cyclictest 4.0 - right now, it says:
> WARN: Running on unknown kernel version...YMMV
> 
> Thanks, Sebastian, for the good work!

Yay, great work! Also I'd like to thank the OSADL members for funding
this activity!

cheers,
daniel
