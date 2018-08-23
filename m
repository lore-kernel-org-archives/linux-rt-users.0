Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail5.windriver.com ([192.103.53.11]:35856 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbeHWTcG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Aug 2018 15:32:06 -0400
Message-ID: <5B7EDA65.7000906@windriver.com>
Date: Thu, 23 Aug 2018 10:01:41 -0600
From: Chris Friesen <chris.friesen@windriver.com>
MIME-Version: 1.0
Subject: Re: SCHED_DEADLINE as user
References: <pl0fsj$ohn$1@blaine.gmane.org> <20180823123739.GC31443@localhost.localdomain> <20180823150040.7da1624f@luca64> <201808230945.02854.gheskett@shentel.net>
In-Reply-To: <201808230945.02854.gheskett@shentel.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Gene Heskett <gheskett@shentel.net>, linux-rt-users@vger.kernel.org

On 08/23/2018 07:45 AM, Gene Heskett wrote:

> LinuxCNC is also run as a common user, never as root.  Thats my $0.02
> from a users viewpoint.

Given that these are special-purpose machines, can I ask why you wouldn't run as 
root if it gave better performance?

Chris
