From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: cpu stall and hyperthread
Date: Thu, 05 Jul 2012 00:52:58 +0200
Message-ID: <4FF4C94A.6040105@osadl.org>
References: <4FEBCDDE.60503@gmail.com> <4FF351C6.3000100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Dong Liu <dliu.cn@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:36619 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755940Ab2GDXSV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Jul 2012 19:18:21 -0400
In-Reply-To: <4FF351C6.3000100@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dong Liu,

>[..]
> BUG: soft lockup - CPU#0 stuck for 279s! [swapper/0:0]
Just a wild guess: Please check your configuration for 
CONFIG_RT_GROUP_SCHED=y. Is it there? If so, disable it and try whether 
this solves your problem.

	-Carsten.
