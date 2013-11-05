From: Aaron Fabbri <ajfabbri@gmail.com>
Subject: [PATCH] trace-cmd: Make read nonblocking in find_time_stamp().
Date: Mon, 4 Nov 2013 16:51:48 -0800
Message-ID: <CAF+KLxuutGDHxzLLaWL-wXsDRyM=4syJcm7wDdEgNxNCpg2TWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	yoshihiro.yunomae.ez@hitachi.com
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This only affects the tsc -> time of day correlation when doing
`trace-cmd record --date`.

get_date_to_ts() writes a dummy event to trace_marker and then reads it back.
Reading it back is done by looping over all per-cpu raw trace pipes and trying
to read.  This read should be non-blocking, because the dummy event can end up
on any CPU.

Signed-off-by: Aaron Fabbri <ajfabbri@gmail.com>
---
 trace-record.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/trace-record.c b/trace-record.c
index 1b1d293..dca8a92 100644
--- a/trace-record.c
+++ b/trace-record.c
@@ -2092,7 +2092,7 @@ static unsigned long long find_time_stamp(struct
pevent *pevent)
                        continue;

                sprintf(file, "%s/%s/trace_pipe_raw", path, name);
-               fd = open(file, O_RDONLY);
+               fd = open(file, O_RDONLY | O_NONBLOCK);
                if (fd < 0)
                        continue;
                do {
-- 
1.8.1.2
