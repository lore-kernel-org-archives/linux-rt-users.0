From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Linux stable vs RT stable and RT dev
Date: Tue, 6 Feb 2018 11:17:18 -0500
Message-ID: <20180206111718.0eb267da@gandalf.local.home>
References: <8155aea247374c058bd7c797124c3d28@ti.com>
        <20180202214611.GD868@jcartwri.amer.corp.natinst.com>
        <1c47b7e6-86d0-cbb0-9b72-7b7d63e46ddc@ti.com>
        <6eecb69a-e60f-f837-bc2c-a627e2660027@ti.com>
        <20180206143426.fdzs6hnvmakqdwiu@linutronix.de>
        <8e201971-d626-7ef6-addd-bbbc32f63770@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        William Mills <wmills@ti.com>, Julia Cartwright <julia@ni.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "Nori, Sekhar" <nsekhar@ti.com>, "Hernandez, Carlos" <ceh@ti.com>,
        "Strashko, Grygorii" <grygorii.strashko@ti.com>
To: Dan Murphy <dmurphy@ti.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752331AbeBFQRU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 6 Feb 2018 11:17:20 -0500
In-Reply-To: <8e201971-d626-7ef6-addd-bbbc32f63770@ti.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 6 Feb 2018 09:47:15 -0600
Dan Murphy <dmurphy@ti.com> wrote:

> This is where we can put an automated job in place to merge GKH rc
> stable into the RT branch and report only upcoming merge conflicts.
> Then no one actually has to report or ask it would just be assumed?

I'd be careful about this. There's a few (not many) subtle changes that
get backported to stable that can break RT. You wont be able to notice
it with compiling, but it can cause deadlocks in certain scenarios.

-- Steve
