From: "Lukas Redlinger" <redlinger@abatec-ag.com>
Subject: AW: preempt rt in commercial use
Date: Wed, 15 Sep 2010 09:09:48 +0200
Message-ID: <4BB241D9153CAB4F8B4F4148080934C702A939CE@comm01.regau.abatec.at>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com> <4C8F82F3.2070603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-rt-users" <linux-rt-users@vger.kernel.org>
To: "Reagan Thomas" <thomasraz@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lilzmailso01.liwest.at ([212.33.55.23]:22584 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750932Ab0IOH3U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 15 Sep 2010 03:29:20 -0400
Received: from mail1.abatec.at ([81.10.186.19])
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <redlinger@abatec-ag.com>)
	id 1Ovm7p-0001GY-Ia
	for linux-rt-users@vger.kernel.org; Wed, 15 Sep 2010 09:09:49 +0200
Content-class: urn:content-classes:message
In-Reply-To: <4C8F82F3.2070603@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


  On 9/14/2010 3:10 AM, Raz wrote:
> Hello
> some companies asked me to show that premmpt rt is comercially used.
> are you using it ?
> Thank you
> raz
> -- 

We use it for our "realtime" local position measurement system (LPM) to
stay in sync with some hardware components. Nothing critical, but if we
miss one cycle (1ms) we have to completely stop the measurement and
start over


