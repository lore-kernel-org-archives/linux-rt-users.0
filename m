From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] arm64: replace read_lock to rcu lock in call_step_hook
Date: Tue, 9 Feb 2016 10:02:19 +0100
Message-ID: <20160209090219.GA13035@linutronix.de>
References: <1454971764-30720-1-git-send-email-yang.shi@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rostedt@goodmis.org, catalin.marinas@arm.com, will.deacon@arm.com,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linaro-kernel@lists.linaro.org
To: Yang Shi <yang.shi@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454971764-30720-1-git-send-email-yang.shi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Yang Shi | 2016-02-08 14:49:24 [-0800]:

>BUG: sleeping function called from invalid context at kernel/locking/r=
tmutex.c:917
=E2=80=A6
>This issue is similar with 62c6c61("arm64: replace read_lock to rcu lo=
ck in
>call_break_hook"), but comes to single_step_handler.
>
>This also solves kgdbts boot test silent hang issue on 4.4 -rt kernel.

I am going to apply this for -RT.

Sebastian
