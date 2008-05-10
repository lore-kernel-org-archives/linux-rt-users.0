From: Robert de Vries <robert.h.de.vries@gmail.com>
Subject: Re: add mlockall option to cyclictest, et al
Date: Sat, 10 May 2008 21:21:19 +0200
Message-ID: <4825F5AF.7010700@gmail.com>
References: <48249E2C.3010601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
	Luis Claudio Goncalves <lclaudio@uudg.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Clark Williams <clark.williams@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:54996 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536AbYEJTVm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 10 May 2008 15:21:42 -0400
Received: by ug-out-1314.google.com with SMTP id h2so407452ugf.16
        for <linux-rt-users@vger.kernel.org>; Sat, 10 May 2008 12:21:40 -0700 (PDT)
In-Reply-To: <48249E2C.3010601@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Clark Williams wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Thomas,
>
> Got a couple of requests for mlockall() in cyclictest, so I added an --mlockall
> option to cyclictest, signaltest and pi_stress.
>   
One small remark: it would be better to do the mlockall() by default. As 
far as I know this should be done always for real-time applications.
I am actually surprised that it is not done already. It is also 
mentioned in the Howto build an RT-application on the RT linux wiki.

    Robert

