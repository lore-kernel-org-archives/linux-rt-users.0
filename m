From: Julien Desfossez <jdesfossez@efficios.com>
Subject: blog post: Monitoring real-time latencies
Date: Wed, 6 Jan 2016 17:04:28 -0500
Message-ID: <20160106220428.GA16537@sinkpad.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: lwn@lwn.net
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

Here is a blog post related to detecting and understanding high
interrupt-processing latencies on real-time systems. It is based on a
new project called latency_tracker that hooks on the existing kernel
tracepoints and executes actions when high latency events occur.

https://lttng.org/blog/2016/01/06/monitoring-realtime-latencies/

It is a work in progress, so if you are interested and/or have any
comments, please let me know.

Thanks,

Julien
