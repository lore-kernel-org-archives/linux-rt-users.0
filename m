Return-Path: linux-kernel-owner@vger.kernel.org
Date: Tue, 11 Nov 2008 18:56:49 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC PATCH 0/3] Series short description
Message-ID: <20081111175649.GA12339@elte.hu>
References: <20081111142323.28477.41235.stgit@dev.haskins.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081111142323.28477.41235.stgit@dev.haskins.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Cc: rostedt@goodmis.org, peterz@infradead.org, linux-kernel@vger.kernel.org, =linux-rt-users@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


* Gregory Haskins <ghaskins@novell.com> wrote:

> Hi Ingo, Steven, Peter,
>   This series applies roughly to mainline as an enhancement to the sched_rt
>   logic.  Peter and I were discussing some of the unecessary overhead in
>   pull_rt_tasks() via IRC, and this is my RFC attempt to address the problem.
> 
>   I have built/booted this on a 4-way C2D Xeon box and it passes preempt-test.
> 
>   Comments, please.

this direction looks very nifty to me. Peter, do you Ack them?

	Ingo
