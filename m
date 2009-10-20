From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [PATCH] futex: Detect mismatched requeue targets
Date: Tue, 20 Oct 2009 15:51:21 -0700
Message-ID: <4ADE3EE9.3090308@us.ibm.com>
References: <1953271756.544571256071596329.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752485AbZJTWv1@vger.kernel.org>
In-Reply-To: <1953271756.544571256071596329.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

John Kacur wrote:
> ----- "Darren Hart" <dvhltc@us.ibm.com> wrote:
> 
>> John Kacur wrote:
>>> Hello Darren
>>>
>>> I took your patch from commit
>> 84bc4af59081ee974dd80210e694ab59ebe51ce8
>>> and I tried to git-cherry-pick it for v2.6.31.4-rt14
>>>
>>> I had a little merge-commit to resolve. That wasn't too hard, but as
>> the 
>>> code is a bit different between the two versions, I would appreciate
>> it if 
>>> you could review the patch, and make sure that it still makes sense
>> for 
>>> v2.6.31.r-rt14
>> Hi John,
>>
>> It looks good to me.  Where did you have the conflicts?
>>
>> --
> 
> The conflict was in the futex_wait_requeue_pi function.
> That's where you really need to double check that the logic still makes sense.

Hi John,

Yes, I suspect the conflict was do to the retry: label. You should have 
already pulled in the spurious wakeup patch, so you should be fine.  The 
patch looks good to me.

Thanks,

-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
