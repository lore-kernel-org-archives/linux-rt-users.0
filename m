From: Bernhard Landauer <oberon@manjaro.org>
Subject: Re: [ANNOUNCE] v4.16.7-rt1
Date: Thu, 10 May 2018 00:24:11 +0200
Message-ID: <9d59d880-db88-118e-8e89-75bb89847706@manjaro.org>
References: <20180503162934.b2ly6jz4a5tydaag@linutronix.de>
 <2d6d2b49-07ce-7125-6086-91a4b6826f4f@manjaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2d6d2b49-07ce-7125-6086-91a4b6826f4f@manjaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 09/05/18 23:45, Bernhard Landauer wrote:
> When compiling 4.16.7-rt1 with gcc 8.1.0 I see tons of these warnings:
>
> warning: objtool: mISDN_FsmEvent()+0x27: sibling call from callable
> instruction with modified stack frame
>
> Any ideas what to make of these?
>
> regards
> Bernhard
Ah ok, meanwhile I found this:
https://lkml.org/lkml/2018/5/8/51

So I guess it's not really anything to worry about ;)
