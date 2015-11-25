From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: [PATCH tip v4 4/5] rcu: Do not call rcu_nocb_gp_cleanup() while
 holding rnp->lock
Date: Wed, 25 Nov 2015 11:29:05 +0100
Message-ID: <56558D71.5050605@bmw-carit.de>
References: <1448370187-10075-1-git-send-email-daniel.wagner@bmw-carit.de>
 <1448370187-10075-5-git-send-email-daniel.wagner@bmw-carit.de>
 <20151124155212.GA1165@fixme-laptop.cn.ibm.com>
 <20151125010118.GB1165@fixme-laptop.cn.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Boqun Feng <boqun.feng@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151125010118.GB1165@fixme-laptop.cn.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Boqun,

On 11/25/2015 02:01 AM, Boqun Feng wrote:
> On Tue, Nov 24, 2015 at 11:52:12PM +0800, Boqun Feng wrote:
>> Hi Daniel,
>>
>> On Tue, Nov 24, 2015 at 02:03:06PM +0100, Daniel Wagner wrote:
>>> rcu_nocb_gp_cleanup() is called while holding rnp->lock. Currently,
>>> this is okay because the wake_up_all() in rcu_nocb_gp_cleanup() will
>>> not enable the IRQs. lockdep is happy.
>>>
>>> By switching over using swait this is not true anymore. swake_up_all()
>>> enables the IRQs while processing the waiters. __do_softirq() can now
>>> run and will eventually call rcu_process_callbacks() which wants to
>>> grap nrp->lock.
>>>
>>> Let's move the rcu_nocb_gp_cleanup() call outside the lock before we
>>> switch over to swait.
>>>
>>
>> But you did introduce swait in this patch ;-)

Argh, that is a fail. I did build all patches individual but seems like
I haven't got the right configuration.

>> [snip]
>>
>>>
>>> Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
>>> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: linux-kernel@vger.kernel.org
>>> ---
>>>  kernel/rcu/tree.c        |  4 +++-
>>>  kernel/rcu/tree.h        |  3 ++-
>>>  kernel/rcu/tree_plugin.h | 16 +++++++++++++---
>>>  3 files changed, 18 insertions(+), 5 deletions(-)
>>>
>>
>> So I tried to build this patch with a config having RCU_EXPERT=y and
>> RCU_NOCB_CPU=y, but I got:

Will update my config accordingly.

Thanks,
Daniel
