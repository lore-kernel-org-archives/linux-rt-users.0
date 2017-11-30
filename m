From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Null pointer 4.14.1-rt3
Date: Thu, 30 Nov 2017 17:24:34 +0100
Message-ID: <20171130162433.GG11362@linutronix.de>
References: <80ce7c3e-2d01-f082-9c21-fc1084a836c8@monom.org>
 <8c913cc2-b2e3-8c2e-e503-aff1428f8ff5@monom.org>
 <20171130112232.4c0cb600@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Wagner <wagi@monom.org>, linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:45901 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbdK3QYg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Nov 2017 11:24:36 -0500
Content-Disposition: inline
In-Reply-To: <20171130112232.4c0cb600@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-11-30 11:22:32 [-0500], Steven Rostedt wrote:
> On Thu, 30 Nov 2017 16:11:22 +0100
> Daniel Wagner <wagi@monom.org> wrote:
> 
> Is it compiled for non SMP? That push pull logic shouldn't be called.

SMP compiled.

> -- Steve

Sebastian
