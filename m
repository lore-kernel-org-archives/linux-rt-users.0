From: "Pradyumna Sampath" <pradyumna.sampath@gmail.com>
Subject: Re: Performance of RT-patch on PowerPC
Date: Fri, 27 Apr 2007 18:55:54 +0530
Message-ID: <f87351060704270625y7c836c3emf266c21423a6cf92@mail.gmail.com>
References: <4631F2F0.4010907@dutchspace.nl>
	 <20070427131033.GG22585@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johan Borkhuis" <j.borkhuis@dutchspace.nl>,
	linux-rt-users@vger.kernel.org
To: "Robert Schwebel" <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:64000 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755824AbXD0NZy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Apr 2007 09:25:54 -0400
Received: by py-out-1112.google.com with SMTP id a29so798863pyi
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Apr 2007 06:25:54 -0700 (PDT)
In-Reply-To: <20070427131033.GG22585@pengutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

> We have it running on MPC5200B, and the 'cyclictest -n -p 90 -t 4' worst
> case numbers are between 50 and 100 us. For more reliable numbers wait a
> few days, we'll re-test with the recently released 2.6.21 soon and I can
> post the results here.

I have the rt-patch working on the lite5200 evaluation board. It is
the 2.6.20-rt3. The numbers are:

./cyclictest -t 1 -p 80 -n -i 10000 -l 10000

Min   Max    Avg
52     122     77

regards
prady
