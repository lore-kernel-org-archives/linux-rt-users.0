From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: cyclictest usage
Date: Thu, 8 Jun 2017 10:46:43 +0200
Message-ID: <20170608084643.xanjpluaxvexa2pv@linutronix.de>
References: <20170526112502.4f6a49ac@tagon>
 <20170602095911.wlqcvsi6zf336z5l@linutronix.de>
 <20170602092612.4069fe8f@tagon.lan>
 <CANGgnMayznQDLuR++ZoQVVJfTCK-tjRk1-HLakSdsQU7eb7EGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Clark Williams <williams@redhat.com>,
        RT <linux-rt-users@vger.kernel.org>,
        John Kacur <jkacur@redhat.com>
To: Austin Schuh <austin@peloton-tech.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:42122 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbdFHIqp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Jun 2017 04:46:45 -0400
Content-Disposition: inline
In-Reply-To: <CANGgnMayznQDLuR++ZoQVVJfTCK-tjRk1-HLakSdsQU7eb7EGg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-06-02 09:54:16 [-0700], Austin Schuh wrote:
> On Fri, Jun 2, 2017 at 7:26 AM, Clark Williams <williams@redhat.com> wrote:
> > Regarding periodic updates, what do you think about providing a way for an app to query the current state of a run? Possibly a memory region that can be mmapped by a process? Or possibly a UNIX domain socket? I'm thinking of the case where you're doing a 48 hour test run on a box where you don't have easy access to the console and would just like to know if a) the box is alive and b) is still showing reasonable values for max latency and jitter.
> >
> > I kinda like the memory region since that's how cyclictest handles output: the measurement threads all dump their data into a cpu-specific memory area and a display thread (running at a low priority) is the one that wakes up, reads the update and printf's to the screen. If we exported that region so that another process could mmap it read-only, that would provide a way to get a snapshot of the run, without actually depending on cyclictest to *do* anything out of the ordinary.
> 
> I might be missing something, but if you want to be able to view the
> status remotely, why not tee the output to a file and tail that from
> the remote session, or use screen/tmux/etc?  That would stay aligned
> with Sebastian's goal of keeping it small and simple.

This works in general for you as a person. But if you want to have the
output read by a machine/script then this won't work.

> Austin

Sebastian
