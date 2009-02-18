From: Sujit Karataparambil <sjt.kar@gmail.com>
Subject: Re: info softirq
Date: Wed, 18 Feb 2009 17:22:27 +0530
Message-ID: <921ca19c0902180352h2aaa859co69d66888f74898d4@mail.gmail.com>
References: <30047d300902180147s1bbdbf45u1b194db53c9480a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Nicola Manica <nicola.manica@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.237]:65368 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbZBRLw3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Feb 2009 06:52:29 -0500
Received: by qb-out-0506.google.com with SMTP id q18so2707868qba.17
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Feb 2009 03:52:28 -0800 (PST)
In-Reply-To: <30047d300902180147s1bbdbf45u1b194db53c9480a9@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This depends on the how the test is designed.

> When I run a simple test I see that most of the time the CPU execute
> IRQ-16 (or the one assigned to my eth card) but softirq-net-rx is
> never triggered.
Is netperf Using this particular interrupt

Kindly read up the documentation.(http://www.unixguide.net/hp/faq/7.1.2.3.shtml)


> If I try the same test with 2.6.24.7-rt24 most of the work is done by
> sirq-net-rx.
How have configured netperf.
