From: Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 084/167] perf probe: Add warning message if
 there is unexpected event name
Date: Mon, 19 Mar 2018 16:07:07 +0000
Message-ID: <20180319160513.16384-84-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Paul Clarke <pc@us.ibm.com>,
        bhargavb <bhargavaramudu@gmail.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit 9f5c6d8777a2d962b0eeacb2a16f37da6bea545b ]

This improve the error message so that user can know event-name error
before writing new events to kprobe-events interface.

E.g.
   =3D=3D=3D=3D=3D=3D
   #./perf probe -x /lib64/libc-2.25.so malloc_get_state*
   Internal error: "malloc_get_state@GLIBC_2" is an invalid event name.
     Error: Failed to add events.
   =3D=3D=3D=3D=3D=3D

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Paul Clarke <pc@us.ibm.com>
Cc: bhargavb <bhargavaramudu@gmail.com>
Cc: linux-rt-users@vger.kernel.org
Link: http://lkml.kernel.org/r/151275040665.24652.5188568529237584489.stgit=
@devbox
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/probe-event.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 03875f9154e7..0195b7e8c54a 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2349,6 +2349,14 @@ static int get_new_event_name(char *buf, size_t len,=
 const char *base,
=20
 out:
 	free(nbase);
+
+	/* Final validation */
+	if (ret >=3D 0 && !is_c_func_name(buf)) {
+		pr_warning("Internal error: \"%s\" is an invalid event name.\n",
+			   buf);
+		ret =3D -EINVAL;
+	}
+
 	return ret;
 }
=20
--=20
2.14.1
