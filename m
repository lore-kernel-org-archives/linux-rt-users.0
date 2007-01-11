From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Results 2.6.17 vs 2.6.19
Date: Thu, 11 Jan 2007 17:44:59 +0100
Message-ID: <45A6698B.4080504@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:1200 "EHLO
	mail.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbXAKQpG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Jan 2007 11:45:06 -0500
Received: from mailserver.berlin.imc-berlin.de (mailserver.berlin.imc-berlin.de [10.0.0.19])
	by mail.imc-berlin.de (Postfix) with ESMTP id C730E2F02B
	for <linux-rt-users@vger.kernel.org>; Thu, 11 Jan 2007 18:39:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id DA88B10B6D
	for <linux-rt-users@vger.kernel.org>; Thu, 11 Jan 2007 17:44:59 +0100 (CET)
Received: from [10.0.2.10] (scholz.berlin.imc-berlin.de [10.0.2.10])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id 018D6A0AD
	for <linux-rt-users@vger.kernel.org>; Thu, 11 Jan 2007 17:44:59 +0100 (CET)
To: linux-rt-users@vger.kernel.org
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi all,

I tried to reproduce the results shown on

http://rt.wiki.kernel.org/index.php/Cyclictest

So I ran

	cyclictest -t 1 -p 80 -i 10000 -n -l 10000		and
	cyclictest -t 1 -p 80 -i 10000 -l 10000

on my emdedded x86 Celeron, 600MHz using 2.6.17-rt3 and 2.6.19-rt15. Funny
enough the older version seems to be better:


2.6.17-rt3 	  4	33 	10
2.6.19-rt15 	  9 	31	19

2.6.17-rt3 	  4	35 	19
2.6.19-rt15 	 16	38	29

2.6.17-rt3 	 11	34 	22
2.6.19-rt15 	 27	55	42

2.6.17-rt3 	 24	47 	33
2.6.19-rt15 	 41	100	56

Is there a known explanation?

Think I try to test some 2.6.20-rt tomorrow ...

-- 
Steven
