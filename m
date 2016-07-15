From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: v4.4.15-rt23 build: 0 failures 3 warnings (v4.4.15-rt23)
Date: Fri, 15 Jul 2016 10:15:48 +0200
Message-ID: <1879489.iCtdiEe2Ca@wuerfel>
References: <E1bNyE1-0002C5-Ld@optimist>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Build bot for Mark Brown <broonie@kernel.org>,
	linaro-kernel@lists.linaro.org,
	rt-users <linux-rt-users@vger.kernel.org>,
	linux-kernel@vger.kernel.org
To: kernel-build-reports@lists.linaro.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <E1bNyE1-0002C5-Ld@optimist>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Friday, July 15, 2016 9:11:58 AM CEST Build bot for Mark Brown wrote:
> 
> Warnings Summary: 3
>           9 ../kernel/sched/core.c:3474:12: warning: 'preemptible_lazy' defined but not used [-Wunused-function]
>           2 ../include/linux/spinlock.h:246:3: warning: 'flags' may be used uninitialized in this function [-Wmaybe-uninitialized]
>           1 ../drivers/xen/balloon.c:155:13: warning: 'release_memory_resource' declared 'static' but never defined [-Wunused-function]

Wiht the latest version we are down again to three warnings, the first
two being introduced through -rt, and the last one waiting for a backport
of 842775f15090 ("xen/balloon: Fix declared-but-not-defined warning")
into stable.

	Arnd
