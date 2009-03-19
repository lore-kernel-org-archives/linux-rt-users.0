From: Rodrigo Amestica <ramestica@lavabit.com>
Subject: Re: real-time priority
Date: Thu, 19 Mar 2009 19:11:19 -0400
Message-ID: <49C2D117.9070501@lavabit.com>
References: <49C2CAFB.5030702@lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from karen.lavabit.com ([72.249.41.33]:59975 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753744AbZCSXLV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 19 Mar 2009 19:11:21 -0400
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id C382811B7E6
	for <linux-rt-users@vger.kernel.org>; Thu, 19 Mar 2009 18:11:19 -0500 (CDT)
Received: from 192.168.1.110 (c-76-104-20-168.hsd1.va.comcast.net [76.104.20.168])
	by lavabit.com with ESMTP id WDQNBDMY8ST3
	for <linux-rt-users@vger.kernel.org>; Thu, 19 Mar 2009 18:11:19 -0500
In-Reply-To: <49C2CAFB.5030702@lavabit.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

yes, i forgot to include the link. now it goes.

http://www.ddj.com/linux-open-source/200900827

Rodrigo Amestica wrote:
> Hi,
>
> general questions from somebody who's just starting to look into the 
> preempt patch.
>
> the article linked below makes direct reference to the behavior of the 
> preempt rt patch. The article was written in 2007. How much of that 
> still holds true in the current version of the patch?
>
> I'm basically wondering about the first sentences in the abstract of 
> that article. The big picture seems to be rather simple: calls to 
> specific linux services could break the performance of a real time 
> task by depending on lower priority tasks to complete that service.
>
> Does this mean that one must always be alert to which system services 
> are invoked during the execution of a real time task? Does the vanilla 
> kernel or the preempt-rt patch tries to somehow detect this condition 
> and alert somehow?
>
> thanks,
> Rodrigo
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe 
> linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> ____________________________________________________________________________________ 
>
> Click here to find the perfect banking opportunity!
> http://ads.lavabit.com/fc/BLSrjwrz8JR8QtO2thrVR65MkKPO7Tm4zsO0sj7xJYVXikFfIocXosXcLFO/ 
>
> ____________________________________________________________________________________ 
>

