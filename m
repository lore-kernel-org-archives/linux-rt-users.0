From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: v3.14.73-rt77 build: 6 failures 10 warnings (v3.14.73-rt77)
Date: Fri, 15 Jul 2016 09:42:40 +0200
Message-ID: <6896332.PzHULJX9vz@wuerfel>
References: <E1bNvA3-0006oU-Ex@optimist>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Build bot for Mark Brown <broonie@kernel.org>,
	kernel-build-reports@lists.linaro.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: linaro-kernel@lists.linaro.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:63722 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbcGOHms (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Jul 2016 03:42:48 -0400
In-Reply-To: <E1bNvA3-0006oU-Ex@optimist>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Friday, July 15, 2016 5:55:39 AM CEST Build bot for Mark Brown wrote:
> 
>         arm64-allnoconfig
> /home/broonie/build/linux-stable-rt/include/asm-generic/preempt.h:10:9: error: implicit declaration of function 'READ_ONCE' [-Werror=implicit-function-declaration]
> 
>         arm64-allmodconfig
> /home/broonie/build/linux-stable-rt/include/asm-generic/preempt.h:10:9: error: implicit declaration of function 'READ_ONCE' [-Werror=implicit-function-declaration]
> 
>         arm-multi_v7_defconfig
> /home/broonie/build/linux-stable-rt/include/asm-generic/preempt.h:10:9: error: implicit declaration of function 'READ_ONCE' [-Werror=implicit-function-declaration]
> 
>         arm-allmodconfig
> /home/broonie/build/linux-stable-rt/include/asm-generic/preempt.h:10:9: error: implicit declaration of function 'READ_ONCE' [-Werror=implicit-function-declaration]
> 
>         arm-allnoconfig
> /home/broonie/build/linux-stable-rt/include/asm-generic/preempt.h:10:9: error: implicit declaration of function 'READ_ONCE' [-Werror=implicit-function-declaration]
> 
>         arm64-defconfig
> /home/broonie/build/linux-stable-rt/include/asm-generic/preempt.h:10:9: error: implicit declaration of function 'READ_ONCE' [-Werror=implicit-function-declaration]

These all started failing yesterday with v3.14.72-rt76, before it was

	v3.14.72-rt75 build: 0 failures 113 warnings (v3.14.72-rt75)

	Arnd
