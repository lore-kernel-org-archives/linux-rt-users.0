From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH tip v5 2/5] kbuild: Add option to turn incompatible
 pointer check into error
Date: Mon, 30 Nov 2015 19:52:18 +0100
Message-ID: <565C9AE2.7040408@monom.org>
References: <1448890711-5812-1-git-send-email-daniel.wagner@bmw-carit.de>
 <1448890711-5812-3-git-send-email-daniel.wagner@bmw-carit.de>
 <565C6A8B.8080103@bmw-carit.de> <20151130173842.GV26643@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kbuild@vger.kernel.org,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Boqun Feng <boqun.feng@gmail.com>
To: paulmck@linux.vnet.ibm.com,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20151130173842.GV26643@linux.vnet.ibm.com>
Sender: linux-kbuild-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Paul,

On 11/30/2015 06:38 PM, Paul E. McKenney wrote:
> On Mon, Nov 30, 2015 at 04:26:03PM +0100, Daniel Wagner wrote:
>> On 11/30/2015 02:38 PM, Daniel Wagner wrote:
>>> With the introduction of the simple wait API we have two very
>>> similar APIs in the kernel. For example wake_up() and swake_up()
>>> is only one character away. Although the compiler will warn
>>> happily the wrong usage it keeps on going an even links the kernel.
>>> Thomas and Peter would rather like to see early missuses reported
>>> as error early on.
>>>
>>> In a first attempt we tried to wrap all swait and wait calls
>>> into a macro which has an compile time type assertion. The result
>>> was pretty ugly and wasn't able to catch all wrong usages.
>>> woken_wake_function(), autoremove_wake_function() and wake_bit_function()
>>> are assigned as function pointers. Wrapping them with a macro around is
>>> not possible. Prefixing them with '_' was also not a real option
>>> because there some users in the kernel which do use them as well.
>>> All in all this attempt looked to intrusive and too ugly.
>>>
>>> An alternative is to turn the pointer type check into an error which
>>> catches wrong type uses. Obviously not only the swait/wait ones. That
>>> isn't a bad thing either. Though for the beginning let's introduce it
>>> as options in the kernel hacking section.
>>
>> The kbuild bot found one problem for allmodconfig. I just send a fix for
>> it ("regmap: Fix leftover from struct reg_default to struct reg_sequence
>> change").
>
> This will result in an updated series, correct?

Not necessarily. This patch just points very verbose the incorrect 
pointer usage in regmap_register_path() users with allmodconfig. This 
series itself should be okay (unless I missed something).

cheers,
daniel
