From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH v2] sched/completion: convert completions to use simple
 wait queues
Date: Mon, 23 May 2016 16:09:52 +0200
Message-ID: <d9a8a48b-70af-3e51-639f-f0ffb3526a11@monom.org>
References: <1461848244-16469-1-git-send-email-wagi@monom.org>
 <fa94c34f-31ea-84fd-ac9f-52ed59c31d12@monom.org>
 <20160516163809.7bac1d54@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: Luiz Capitulino <lcapitulino@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160516163809.7bac1d54@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

[Sorry for the late response. I was a few days on holiday]

On 05/16/2016 10:38 PM, Luiz Capitulino wrote:
> On Thu, 12 May 2016 16:08:34 +0200
> Daniel Wagner <wagi@monom.org> wrote:
> 
>> In short, I haven't figured out yet why the kernel builds get slightly slower. 
> 
> You're doing make -j 200, right? How many cores do you have? Couldn't it
> be that you're saturating your CPUs?

For the above numbers I used mmtest as test framework with 2x<NR CPUs>,
that is 128.

> You could try make -j<NR CPUs>, or some process creation benchmark. Although
> I don't know what's the best way to measure this.

Yeah, I consider the kernel benchmark not as a good workload to figure
out what's going on. It's more like to see something is hiding. The
micro benchmarks I used so far couldn't highlight the problem(s). I
guess more testing is needed.

cheers,
daniel
