From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: Kernel config options that impact latency
Date: Thu, 4 Jan 2018 11:24:37 -0800
Message-ID: <CANGgnMb_EdRP7pUFktSMEC5n4MYbMytMoruR-dTrVAJ7a0dbyA@mail.gmail.com>
References: <D5D6254030DBC644B6EE58B333BFBB1E9D96DC30@ORSMSX101.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: "Hindman, Gavin" <gavin.hindman@intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:46039 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750959AbeADTY6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Jan 2018 14:24:58 -0500
Received: by mail-yw0-f177.google.com with SMTP id y187so963030ywd.12
        for <linux-rt-users@vger.kernel.org>; Thu, 04 Jan 2018 11:24:58 -0800 (PST)
In-Reply-To: <D5D6254030DBC644B6EE58B333BFBB1E9D96DC30@ORSMSX101.amr.corp.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Jan 4, 2018 at 10:29 AM, Hindman, Gavin <gavin.hindman@intel.com> wrote:
> Since we seem to be in knowledge-sharing mode, is there an existing list of kernel config parameters, outside of those required to enable preempt_rt, known to impact or improve general system latency?  I didn't find anything prowling the various wikis.

For ARM platforms, we've found turning off power management helps.
The book-keeping was costing a lot of time in latency critical spots.

Austin
