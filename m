From: Tarkan Erimer <tarkan@netone.net.tr>
Subject: Re: [PATCH] 2.6.25.4-rt6: missing global_rt_runtime() in sched.c
Date: Mon, 09 Jun 2008 15:54:43 +0300
Message-ID: <484D2813.3060500@netone.net.tr>
References: <7688fdc041a8f848b0627dccccddcf12@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: ciaby <ciaby@autistici.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.netone.net.tr ([193.192.98.182]:3885 "EHLO
	mail.netone.net.tr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756533AbYFIMyr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Jun 2008 08:54:47 -0400
In-Reply-To: <7688fdc041a8f848b0627dccccddcf12@localhost>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

ciaby wrote:
> I already sent this patch, but seems that nobody cared... the last 2
> revisions of the -rt kernel don't compile properly.
> Second patch to fix this.
> Regards
>
> Giovanni "ciaby" Civardi
>   
Thanks for the patch. It worked perfectly for me.
