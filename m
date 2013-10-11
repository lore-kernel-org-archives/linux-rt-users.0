From: Mario Kleiner <mario.kleiner@tuebingen.mpg.de>
Subject: Re: [Intel-gfx] BUG: sleeping function called from invalid context
 on 3.10.10-rt7
Date: Fri, 11 Oct 2013 15:49:34 +0200
Message-ID: <525801EE.2090807@tuebingen.mpg.de>
References: <5230895B.5070400@hurleysoftware.com> <20130911113845.6d56a556@gandalf.local.home> <5230C52E.3050801@hurleysoftware.com> <5238B288.3000704@hurleysoftware.com> <CAKMK7uG9s8W6yebkmuJe0XHGsoru4_9FzGqfmKWtMFyCAfQZqA@mail.gmail.com> <523CC728.4040302@tuebingen.mpg.de> <20130923083841.GT4531@intel.com> <5242674A.8020100@tuebingen.mpg.de> <20130925101301.6cbe5d0f@gandalf.local.home> <52445DEF.1060007@gmail.com> <20131011101800.GE6983@linutronix.de> <20131011083757.7d3db58c@gandalf.local.home> <5257FD6E.6070809@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mario Kleiner <mario.kleiner.de@gmail.com>,
	Peter Hurley <peter@hurleysoftware.com>,
	Clark Williams <williams@redhat.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	LKML <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Dave Airlie <airlied@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	=?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5257FD6E.6070809@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 10/11/2013 03:30 PM, Sebastian Andrzej Siewior wrote:
> On 10/11/2013 02:37 PM, Steven Rostedt wrote:
>> On Fri, 11 Oct 2013 12:18:00 +0200
>> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>>
>>> * Mario Kleiner | 2013-09-26 18:16:47 [+0200]:
>>>
>>>> Good! I will do that. Thanks for clarifying the irq and constraints
>>>> on raw locks in the other thread.
>>>
>>> Are there any suggestions for "now"?  preempt_disable_nort() like Luis
>>> suggesed?
>>>
>>
>> The preempt_disable_nort() is rather pointless, because the
>> preempt_disable() was added specifically for -rt. When PREEMPT_RT is
>> not enabled, preemption is disabled there already by the previous calls
>> to spin_lock().
>
> Either way. Then I remove the preempt_enable/disable call. Any
> objections?
>

Good with me. I'm currently working on a replacement.
-mario

>> -- Steve
>>
> Sebastian
>
