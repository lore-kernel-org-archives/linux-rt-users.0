From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] kmemleak: Turn kmemleak_lock to raw spinlock on RT
Date: Thu, 22 Nov 2018 11:16:12 +0100
Message-ID: <20181122101611.tmbmylbshd4mrnxi@linutronix.de>
References: <1542877459-144382-1-git-send-email-zhe.he@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: catalin.marinas@arm.com, tglx@linutronix.de, rostedt@goodmis.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: zhe.he@windriver.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1542877459-144382-1-git-send-email-zhe.he@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-11-22 17:04:19 [+0800], zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
> 
> kmemleak_lock, as a rwlock on RT, can possibly be held in atomic context and
> causes the follow BUG.

please use
 [PATCH RT … ]

in future while posting for RT. And this was (and is) on my TODO list.

Sebastian
