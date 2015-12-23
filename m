From: Christoph Mathys <eraserix@gmail.com>
Subject: Re: [ANNOUNCE] 4.1.15-rt17
Date: Wed, 23 Dec 2015 13:43:49 +0100
Message-ID: <CALqGcGqpZRwv1RbXwyYxsbGOJg8u7HYM_8VTHbjfi4fUkDmHtQ@mail.gmail.com>
References: <20151222165601.GG27274@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Linux RT Users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:33623 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933040AbbLWMnv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Dec 2015 07:43:51 -0500
Received: by mail-lb0-f173.google.com with SMTP id sv6so39097377lbb.0
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Dec 2015 04:43:50 -0800 (PST)
In-Reply-To: <20151222165601.GG27274@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Has anyone tried the following lately?

echo 1 > /sys/kernel/debug/tracing/events/hist/preemptirqsoff_hist

This will crash my system immediately (back to BIOS POST).

Christoph
