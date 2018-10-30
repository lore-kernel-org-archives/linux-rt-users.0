From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH RT 1/2] x86/kconfig: Fall back to ticket spinlocks
Date: Tue, 30 Oct 2018 09:37:05 +0100
Message-ID: <3f4d0e85-c48a-17bf-c180-00ddf5584484@monom.org>
References: <20181029201617.24733-1-wagi@monom.org>
 <20181029201617.24733-2-wagi@monom.org>
 <20181029231244.xfj42ucddp7xnoae@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>,
        Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181029231244.xfj42ucddp7xnoae@linutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 30/10/2018 00:12, Sebastian Andrzej Siewior wrote:
> On 2018-10-29 21:16:16 [+0100], Daniel Wagner wrote:
>> From: Daniel Wagner <daniel.wagner@siemens.com>
>>
>> v4.4.162-rt176-rc1 stable review patch.
>> If anyone has any objections, please let me know.
> 
> I though that we are going to route this via Greg/stable for v4.4?

ah yes... I should not send out patches after a long day of work...

next try
