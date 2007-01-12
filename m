From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: Results 2.6.17 vs 2.6.19
Date: Fri, 12 Jan 2007 11:17:24 +0100
Message-ID: <45A76034.307@imc-berlin.de>
References: <45A6698B.4080504@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:1568 "EHLO
	mail.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161061AbXALKR2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 12 Jan 2007 05:17:28 -0500
Received: from mailserver.berlin.imc-berlin.de (mailserver.berlin.imc-berlin.de [10.0.0.19])
	by mail.imc-berlin.de (Postfix) with ESMTP id F34B72F02B
	for <linux-rt-users@vger.kernel.org>; Fri, 12 Jan 2007 12:11:43 +0100 (CET)
To: Steven Scholz <steven.scholz@imc-berlin.de>
In-Reply-To: <45A6698B.4080504@imc-berlin.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

I wrote:

> So I ran
> 
> 	cyclictest -t 1 -p 80 -i 10000 -n -l 10000		and
> 	cyclictest -t 1 -p 80 -i 10000 -l 10000
> 
> on my emdedded x86 Celeron, 600MHz using 2.6.17-rt3 and 2.6.19-rt15. Funny
> enough the older version seems to be better:
> 
> 
> 2.6.17-rt3 	 24	47 	33
> 2.6.19-rt15 	 41	100	56
> ...
> Is there a known explanation?
> 
> Think I try to test some 2.6.20-rt tomorrow ...

2.6.20-rc4-rt3 is similar to 2.6.19 thus still slower then 2.6.17 ...

--
Steven
