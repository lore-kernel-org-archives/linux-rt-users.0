From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: [PATCH tip v6 2/5] kbuild: Add option to turn incompatible
 pointer check into error
Date: Fri, 5 Feb 2016 09:16:07 +0100
Message-ID: <56B45A47.4090400@bmw-carit.de>
References: <1453992270-4688-1-git-send-email-daniel.wagner@bmw-carit.de>
 <1453992270-4688-3-git-send-email-daniel.wagner@bmw-carit.de>
 <56AB5867.6020405@bmw-carit.de> <20160129185523.GZ8889@windriver.com>
 <56AEFFF1.1010404@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>,
	<linux-kbuild@vger.kernel.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Boqun Feng <boqun.feng@gmail.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <56AEFFF1.1010404@bmw-carit.de>
Sender: linux-kbuild-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 02/01/2016 07:49 AM, Daniel Wagner wrote:
> On 01/29/2016 07:55 PM, Paul Gortmaker wrote:
>> [Re: [PATCH tip v6 2/5] kbuild: Add option to turn incompatible pointer check into error] On 29/01/2016 (Fri 13:17) Daniel Wagner wrote:
>>
>>> On 01/28/2016 03:44 PM, Daniel Wagner wrote:
>>>> +# enforce correct pointer usage
>>>> +KBUILD_CFLAGS += $(call cc-option,-Werror=incompatible-pointer-types)
>>>> +
>>>
>>> As it turns out there are a few fallouts by that one. I'll send fixes
>>> for it.
>>
>> Did you try non-x86 builds with this applied?   I'd be really surprised
>> if there were just a few, once you did allyesconfig/allmodconfig for
>> ARM, MIPS, PPC, etc.
> 
> I have tried this with non-x86 builds and apart of a few problems all
> looked fine. As it turns out I was using too old cross tools from
> kernel.org [1]. Luckily Fengguang's kbuild robot did catch a bunch of
> them (see the patches in this series).

It turns out this week was particular bad for doing anything productive.
Anyway, I found some time to fire up some cross compilers and it looks
promising.

I used the cross compiler version 5.2.1 shipped by Fedora 23
and run allyesconfig/allmodconfig for ARM, ARM64, MIPS64, PPC64
(swait-v7 and 4.5-rc2). No new errors popped up.

With some luck I get some more architectures covered soon.

cheers,
daniel
