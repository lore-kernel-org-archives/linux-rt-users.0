From: Christoph Mathys <eraserix@gmail.com>
Subject: Re: Hung task for proc_cgroup_show
Date: Wed, 23 Dec 2015 07:53:11 +0100
Message-ID: <CALqGcGq49tesfe+fEaV=Y20z8+1MGKu02sPOjP64edMhKeamMQ@mail.gmail.com>
References: <CALqGcGoMqJuvzQpGb84LzyxQCJADB73YEreND0HgOFK5DOQ6ig@mail.gmail.com>
	<20150714150016.GC21820@linutronix.de>
	<CALqGcGqzWsNacBHRUgFOrtJB6MSoqR+kDJteA8mgi9E4_o8vxw@mail.gmail.com>
	<20151211161450.GA6720@linutronix.de>
	<CALqGcGob5_qWeK1ndErqN9Z3DkGTPciTojjkEOkvauZyNd59Bg@mail.gmail.com>
	<20151221181153.GB6714@linutronix.de>
	<CALqGcGrzpA_95LiL+4dHKX6xf7iwz-uL0_y8BtnQJgKLkZD-4w@mail.gmail.com>
	<20151222135153.GB27274@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35502 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933084AbbLWGxN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Dec 2015 01:53:13 -0500
Received: by mail-lf0-f49.google.com with SMTP id l133so141120943lfd.2
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Dec 2015 22:53:12 -0800 (PST)
In-Reply-To: <20151222135153.GB27274@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Dec 22, 2015 at 2:51 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> You could try without CONFIG_RESOURCE_COUNTERS or switch to v4.1 instead
> since it has the file in question removed as per 5b1efc027c0b ("kernel:
> res_counter: remove the unused API").

Yup, 4.1 does not show this behaviour.

Thanks.
Christoph
