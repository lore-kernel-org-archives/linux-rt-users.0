From: Tvrtko Ursulin <tvrtko@ursulin.net>
Subject: Re: [PATCH] Fix crypto api init for 3.6.4-rt10
Date: Tue, 30 Oct 2012 18:24:50 +0000
Message-ID: <50901B72.6090201@ursulin.net>
References: <5083C61C.5090807@gmail.com> <5083E4A8.3060501@ursulin.net> <5083E87B.2080908@gmail.com> <5083EC61.8070505@ursulin.net> <50844D01.9090805@gmail.com> <5084551E.5040304@ursulin.net> <508ED985.5060301@ursulin.net> <508EDD6E.7030908@gmail.com> <508EE395.9010709@ursulin.net> <508EEAF2.4090506@ursulin.net> <20121030094001.GV639@pengutronix.de> <508FA405.2050509@redhat.com> <508FF1D6.3030900@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-rt-users@vger.kernel.org,
	dm-crypt@saout.de, linux-kernel@vger.kernel.org, okozina@redhat.com
To: Milan Broz <mbroz@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <508FF1D6.3030900@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Hi,

On 30/10/12 15:27, Milan Broz wrote:
> Fix crypto api for 3.6.4-rt10 (broken only in realtime patchset)
>
> In peterz-srcu-crypto-chain.patch the blocking notifier is changed
> to srcu notifier and added initialization to module init fucntion.
>
> Later, in crypto-make-core-static-and-init-scru-early.patch, is that
> initialization added also to core_initcall().
>
> This patch removes crypto_chain init from algapi initialization,
> because this function is called later and already initialized
> cryptomgr notifier is lost.
>
> This cause a failure in initialization of larval algorithms,
> like e.g. cbc(aes).

Thanks for the quick fix!

Tvrtko
