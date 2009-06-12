From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: Analyze sched_switch ftrace data with vcd viewer
Date: Fri, 12 Jun 2009 16:53:23 +0200
Message-ID: <4A326BE3.40202@osadl.org>
References: <4A281971.1040406@home.nl> <49b7c2350906112312o1ca2aefeq658e6e645021c63f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Herman ten Brugge <hermantenbrugge@home.nl>,
	linux-rt-users@vger.kernel.org
To: GeunSik Lim <leemgs1@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:44658 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869AbZFLPAF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 12 Jun 2009 11:00:05 -0400
In-Reply-To: <49b7c2350906112312o1ca2aefeq658e6e645021c63f@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear GeunSik Lim,

> [..]
> But I can not show normal result using "#> gtkware trace.vcd" command.
> * screenshot : http://blogfiles5.naver.net/data43/2009/6/12/228/gtkwave-vcd-20090609.1503-invain.png
The Quick HOWTO on our download page says:
To select a particular data channel within gtkwave, select sched_switch 
in the top left window and drag and drop the label of the requested 
channel from the bottom left window labeled "Signals" to the drop area 
at the left side of the main wave display area (also labeled "Signals").

Please do so. I have every confidence that it will work.

	Carsten.
