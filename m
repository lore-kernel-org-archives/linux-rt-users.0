From: Jacky Lam <lamshuyin@gmail.com>
Subject: Re: Protection of critical section in PREEMPT_RT
Date: Thu, 31 Jan 2013 17:27:17 +0800
Message-ID: <CAHX1yNTKw8vr2v01Eft1tVV5YrP-7Zw=3fk9iF6YJYfbnBJ9LQ@mail.gmail.com>
References: <CAHX1yNTSObcxNrvsBnPw8QzUWTb4zzs_faZZ1bbGU1L8xzgpsQ@mail.gmail.com>
	<50FE68EF.8060909@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:52075 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748Ab3AaJ1S (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 31 Jan 2013 04:27:18 -0500
Received: by mail-ie0-f174.google.com with SMTP id k10so2075294iea.19
        for <linux-rt-users@vger.kernel.org>; Thu, 31 Jan 2013 01:27:18 -0800 (PST)
In-Reply-To: <50FE68EF.8060909@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thanks Stano,

I am still debugging this driver. But I find very strange that
sometimes printk() in interrupt handler do not output anything. This
makes me very difficult to debug. Is it RT patch's expected behaviour?
Or I am doing something wrong??

Jackky
