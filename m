From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 4.8.6-rt5 ftrace function_graph hangs
Date: Mon, 21 Nov 2016 09:45:59 -0500
Message-ID: <20161121094559.68a8296a@gandalf.local.home>
References: <d275a464-c787-6e21-0d3f-bbb3d854176e@windriver.com>
        <20161118113524.43f6ff3c@gandalf.local.home>
        <1785742b-8094-56af-01b9-6bac5c67865f@windriver.com>
        <67df43c6-ac39-dea0-025d-5fce434d2743@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <tglx@linutronix.de>, <linux-rt-users@vger.kernel.org>,
        Yang Shi <yang.shi@windriver.com>
To: He Zhe <zhe.he@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0215.hostedemail.com ([216.40.44.215]:60937 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932333AbcKUOqF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 21 Nov 2016 09:46:05 -0500
In-Reply-To: <67df43c6-ac39-dea0-025d-5fce434d2743@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 21 Nov 2016 16:30:40 +0800
He Zhe <zhe.he@windriver.com> wrote:


> And I've tried on "a7fac75 Linux 4.8.1" and the latest linux-4.8.y-rt-rebase branch.They have the same issue.

Would you be able to bisect this?

-- Steve
