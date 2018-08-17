Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-wr1-f51.google.com ([209.85.221.51]:33628 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbeHQMx4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 17 Aug 2018 08:53:56 -0400
Received: by mail-wr1-f51.google.com with SMTP id v90-v6so3396180wrc.0
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Aug 2018 02:51:10 -0700 (PDT)
Date: Fri, 17 Aug 2018 11:51:06 +0200
From: Juri Lelli <juri.lelli@gmail.com>
Subject: Re: SCHED_DEADLINE as user
Message-ID: <20180817095106.GB27071@localhost.localdomain>
References: <pl0fsj$ohn$1@blaine.gmane.org>
 <0ac9fabc-c316-2a59-c3dd-c7b4e4f93209@bristot.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ac9fabc-c316-2a59-c3dd-c7b4e4f93209@bristot.me>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Tim Blechmann <tim@klingt.org>
Cc: Daniel Bristot de Oliveira <daniel@bristot.me>, linux-rt-users@vger.kernel.org

Hi Tim,

On 15/08/18 10:21, Daniel Bristot de Oliveira wrote:
> 
> 
> On 08/15/2018 08:08 AM, Tim Blechmann wrote:
> > hi all,
> > 
> > i wonder, what's the preferred way to obtain SCHED_DEADLINE privileges
> > as non-root user?
> 
> Hi Tim,
> 
> It is still not possible to use sched deadline as a non-root user :-(.

Indeed, but Tim, is this hindering you from experimenting/using
DEADLINE?

Asking because we might want to have a look at how to relax the current
privileges requirement.

Best,

- Juri
