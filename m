From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 0/9] v4.4-rt2: fix compilation warnings and errors
Date: Mon, 18 Jan 2016 18:54:29 +0100
Message-ID: <20160118175429.GD12309@linutronix.de>
References: <1452885673-30891-1-git-send-email-anders.roxell@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, khilman@kernel.org
To: Anders Roxell <anders.roxell@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:47966 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbcARRyb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Jan 2016 12:54:31 -0500
Content-Disposition: inline
In-Reply-To: <1452885673-30891-1-git-send-email-anders.roxell@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Anders Roxell | 2016-01-15 20:21:04 [+0100]:

>Hi,
Hi,

>This patchset fixes some build warnings and errors that were introduced by
>v4.4-rt2. To build these patches they should be applied on top of patch [1], [2]
>and [3].

Thanks.

The AT91 pieces and hrtimer should have been fixed by now. An omap patch
has been dropped which makes #9 obsolete.
I picked up #8 and the patch you reference [3] and hope they pop-up
upstream soon :)

>Cheers,
>Anders
>[3] http://www.spinics.net/lists/kernel/msg2162906.html

Sebastian
