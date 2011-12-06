From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Where can I get the latest cyclictest or the version 0.72
Date: Tue, 06 Dec 2011 11:13:13 -0500
Message-ID: <1323187993.30977.91.camel@frodo>
References: <CAEQjb-TXX8bUULQVWOAQZjAxj7DVrA2ehs039qEH5zSe2BSfLA@mail.gmail.com>
	 <1323096173.30977.77.camel@frodo> <20111205085950.751ffea3@redhat.com>
	 <CAEQjb-S6Ezy=d4k6p93uUcj+Osovc0kE6POmbYfjyS=dAARc8w@mail.gmail.com>
	 <20111205103609.1ad7b373@redhat.com>
	 <CAEQjb-TVaBZHbRBodLsBBPjJAMCd1xw9c_iLA-wX4ZmhRuacgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Bei Guan <gbtju85@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:46788 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab1LFQNU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Dec 2011 11:13:20 -0500
In-Reply-To: <CAEQjb-TVaBZHbRBodLsBBPjJAMCd1xw9c_iLA-wX4ZmhRuacgQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2011-12-05 at 21:05 -0500, Bei Guan wrote:
> apt-get install github.com/clrkwllms/rt-tests.git

Um, you can't use apt-get to install a git repo.

You want:

apt-get install rt-tests

-- Steve


