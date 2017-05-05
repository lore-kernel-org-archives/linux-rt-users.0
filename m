From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: realtime ethernet
Date: Fri, 5 May 2017 10:52:07 -0500
Message-ID: <20170505155207.GB27055@unpythonic.net>
References: <568ec603-8a01-3726-dd8e-6cf04e055767@numalliance.com>
 <d3ca141e-916f-d7f1-e840-c1a450921f36@numalliance.com>
 <20170503213309.GA27055@unpythonic.net>
 <f463783b-f11b-7139-a9b2-db0d7a39d956@numalliance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: linux-rt-users@vger.kernel.org
To: =?iso-8859-1?Q?St=E9phane?= Ancelot <sancelot@numalliance.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from afk.unpythonic.net ([138.68.55.246]:46442 "EHLO
        afk.unpythonic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751429AbdEEPwK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 May 2017 11:52:10 -0400
Content-Disposition: inline
In-Reply-To: <f463783b-f11b-7139-a9b2-db0d7a39d956@numalliance.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, May 04, 2017 at 09:54:36AM +0200, Stéphane Ancelot wrote:
> Hi,
> 
> In any cases, I understand that the classic linux nic driver needs
> modifications to be realtime. (refer to rtnet work)
> 
> because of the NAPI stack not really suitable for realtime.
> 
> So, I  understand that these modifications are not parts of the rt preeempt
> patch today.

We are working without any additional RT networking patches except those in the
debian -rt kernels.

Jeff
