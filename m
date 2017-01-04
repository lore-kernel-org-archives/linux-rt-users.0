From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: v4.4-rt build: 0 failures 1 warnings (v4.4.38-rt49-19-gb7f7e93)
Date: Wed, 04 Jan 2017 21:12:48 +0100
Message-ID: <2793909.Ge7VKzWuc6@wuerfel>
References: <E1cOok1-00015I-Fv@optimist>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Build bot for Mark Brown <broonie@kernel.org>,
        kernel-build-reports@lists.linaro.org,
        linux-rt-users@vger.kernel.org
To: linaro-kernel@lists.linaro.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:64586 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbdADUM4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Jan 2017 15:12:56 -0500
In-Reply-To: <E1cOok1-00015I-Fv@optimist>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wednesday, January 4, 2017 4:48:45 PM CET Build bot for Mark Brown wrote:
> 
> -------------------------------------------------------------------------------
> 
> Warnings Summary: 1
> 	  1 ../kernel/cpu.c:509:13: warning: 'cpu_notify_nofail' defined but not used [-Wunused-function]

The last build report we got for v4.4-rt did not have this warning. That
was v4.4.32-rt43-188-g692bf90. I don't know what happened to the version
numbers inbetween, but at some point a regression must have crept into either
the stable kernels or the -rt patches.

	Arnd
