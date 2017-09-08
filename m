From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 33/40] tracing: Add hist trigger support for variable
 reference aliases
Date: Fri, 8 Sep 2017 15:09:55 -0400
Message-ID: <20170908150955.2ea9351e@gandalf.local.home>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
        <35c0e47907c9acaa847c83ad0ec3af0092cde250.1504642143.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756581AbdIHTJ6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 8 Sep 2017 15:09:58 -0400
In-Reply-To: <35c0e47907c9acaa847c83ad0ec3af0092cde250.1504642143.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue,  5 Sep 2017 16:57:45 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> Add support for alias=$somevar where alias can be used as
> onmatch($alias).

This change log is very lacking. What exactly is the purpose of alias?

Sounds like the variable is going undercover.

-- Steve

> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
