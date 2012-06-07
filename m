From: David Daney <ddaney.cavm@gmail.com>
Subject: Re: [PATCH RT 3/4] mips-remove-smp-reserve-lock.patch
Date: Thu, 07 Jun 2012 12:08:22 -0700
Message-ID: <4FD0FC26.3030101@gmail.com>
References: <20120607155148.698959275@goodmis.org>	 <20120607155221.836885041@goodmis.org> <4FD0E9F9.60906@gmail.com> <1339095399.13377.2.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Ralf Baechle <ralf@linux-mips.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1339095399.13377.2.camel@gandalf.stny.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 06/07/2012 11:56 AM, Steven Rostedt wrote:
> On Thu, 2012-06-07 at 10:50 -0700, David Daney wrote:
>> On 06/07/2012 08:51 AM, Steven Rostedt wrote:
>>> From: Thomas Gleixner<tglx@linutronix.de>
>>>
>>> Instead of making the lock raw, remove it as it protects nothing.
>>
>> I don't know how you guys are managing the RT branch, but this seems
>> quite similar to:
>>
>> a3c8b4faeeccb33dbad6969bc9e50bf409f167e7 (MIPS: Cavium: Remove
>> smp_reserve_lock.)
>
> Great! Then we don't need to worry about it :-)
>
> But as it doesn't seem that this patch was marked as stable, we will be
> carrying it in -rt where we support older kernels.
>
> Should it go to mainline stable?
>

I don't think it is necessary.  As far as I know, RT may be the only 
thing that needs it.

David Daney

> -- Steve
>
>>
>> David Daney
>>
>
>
