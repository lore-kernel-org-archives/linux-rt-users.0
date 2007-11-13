From: "Jaswinder Singh" <jaswinderlinuxrt@gmail.com>
Subject: Re: cyclic test results on 8 way (2.6.23.1-rt7 through 2.6.23.1-rt11)
Date: Tue, 13 Nov 2007 19:10:37 +0530
Message-ID: <1985e0f60711130540j43eac275p4f77bb373bb4c958@mail.gmail.com>
References: <200711072334.40216.dvhltc@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Steven Rostedt" <rostedt@goodmis.org>,
	"Gregory Haskins" <ghaskins@novell.com>
To: "Darren Hart" <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.180]:56587 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575AbXKMNkj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 Nov 2007 08:40:39 -0500
Received: by el-out-1112.google.com with SMTP id j27so464791elf
        for <linux-rt-users@vger.kernel.org>; Tue, 13 Nov 2007 05:40:38 -0800 (PST)
In-Reply-To: <200711072334.40216.dvhltc@us.ibm.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

hello Darren,


On Nov 8, 2007 1:04 PM, Darren Hart <dvhltc@us.ibm.com> wrote:
> # ./cyclictest -n -i 10000 -l 10000 -p 95

10000 (10 milliseconds) interval seems to be quite big for current
machine. 10 milliseconds is good for 10 to 15 years old machine but
not for latest machines.

I think we should try -i 1000 or -i 4000 .

Thank you,

Jaswinder Singh.
