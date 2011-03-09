Return-Path: jkacur@gmail.com
MIME-Version: 1.0
Sender: jkacur@gmail.com
In-Reply-To: <4D779D0F.8020003@osadl.org>
References: <1299683339-14381-1-git-send-email-leemgs1@gmail.com>
	<4D779D0F.8020003@osadl.org>
Date: Wed, 9 Mar 2011 21:26:06 +0100
Message-ID: <AANLkTinQD_X8-66FU01eFdFdFh7gAY1CfwQSopQkteYZ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] cyclictest: Fixed incorrect wakeup reset interface
From: John Kacur <jkacur@redhat.com>
Content-Type: multipart/alternative; boundary=0015175cd330e469cc049e128997
To: Carsten Emde <C.Emde@osadl.org>
Cc: Geunsik Lim <leemgs1@gmail.com>, williams@redhat.com, linux-rt-users@vger.kernel.org, tglx@linutronix.de
List-ID: <linux-rt-users.vger.kernel.org>

--0015175cd330e469cc049e128997
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Mar 9, 2011 at 4:30 PM, Carsten Emde <C.Emde@osadl.org> wrote:

> On 03/09/2011 04:08 PM, Geunsik Lim wrote:
>
>> When we try to run ftrace with cyclictest command of rt-test,
>> We view the error according to base kernel version.
>> We need to modify this hard coded interface.
>>
>> Signed-off-by: Geunsik Lim<geunsik.lim@samsung.com>
>>
> We need a space here: Geunsik Lim <geunsik.lim@samsung.com>
>
>
>  ---
>>  src/cyclictest/cyclictest.c |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>
> Oops, this is still old, it's only 1 insertion now. You could have produced
> a real patch, couldn't you?
>
>
>  diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
>> index 0847aed..abc0b4e 100644
>> --- a/src/cyclictest/cyclictest.c
>> +++ b/src/cyclictest/cyclictest.c
>> @@ -487,7 +487,7 @@ static void setup_tracer(void)
>>                                setkernvar(traceroptions, traceptr[i]);
>>                }
>>                setkernvar("tracing_max_latency", "0");
>> -               setkernvar("latency_hist/wakeup_latency/reset", "1");
>> +               setkernvar("latency_hist/wakeup/reset", "1");
>>        } else {
>>                setkernvar("trace_all_cpus", "1");
>>                setkernvar("trace_freerunning", "1");
>>
> Acked-by: Carsten Emde <C.Emde@osadl.org>
>
>
Did it used to be wakeup_latency in an older version that we still need to
support?

--0015175cd330e469cc049e128997
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Mar 9, 2011 at 4:30 PM, Carsten =
Emde <span dir=3D"ltr">&lt;<a href=3D"mailto:C.Emde@osadl.org">C.Emde@osadl=
.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"bo=
rder-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding=
-left: 1ex;">
<div class=3D"im">On 03/09/2011 04:08 PM, Geunsik Lim wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
When we try to run ftrace with cyclictest command of rt-test,<br>
We view the error according to base kernel version.<br>
We need to modify this hard coded interface.<br>
<br>
Signed-off-by: Geunsik Lim&lt;<a href=3D"mailto:geunsik.lim@samsung.com" ta=
rget=3D"_blank">geunsik.lim@samsung.com</a>&gt;<br>
</blockquote></div>
We need a space here: Geunsik Lim &lt;<a href=3D"mailto:geunsik.lim@samsung=
.com" target=3D"_blank">geunsik.lim@samsung.com</a>&gt;<div class=3D"im"><b=
r>
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
---<br>
 =A0src/cyclictest/cyclictest.c | =A0 =A03 ++-<br>
 =A01 files changed, 2 insertions(+), 1 deletions(-)<br>
</blockquote></div>
Oops, this is still old, it&#39;s only 1 insertion now. You could have prod=
uced a real patch, couldn&#39;t you?<div class=3D"im"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c<br>
index 0847aed..abc0b4e 100644<br>
--- a/src/cyclictest/cyclictest.c<br>
+++ b/src/cyclictest/cyclictest.c<br>
@@ -487,7 +487,7 @@ static void setup_tracer(void)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0setkernvar(=
traceroptions, traceptr[i]);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0setkernvar(&quot;tracing_max_latency&quot;,=
 &quot;0&quot;);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 setkernvar(&quot;latency_hist/wakeup_latency/=
reset&quot;, &quot;1&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 setkernvar(&quot;latency_hist/wakeup/reset&qu=
ot;, &quot;1&quot;);<br>
 =A0 =A0 =A0 =A0} else {<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0setkernvar(&quot;trace_all_cpus&quot;, &quo=
t;1&quot;);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0setkernvar(&quot;trace_freerunning&quot;, &=
quot;1&quot;);<br>
</blockquote></div>
Acked-by: Carsten Emde &lt;<a href=3D"mailto:C.Emde@osadl.org" target=3D"_b=
lank">C.Emde@osadl.org</a>&gt;<div><div></div><div class=3D"h5"><br></div><=
/div></blockquote><div><br>Did it used to be wakeup_latency in an older ver=
sion that we still need to support? <br>
</div></div>

--0015175cd330e469cc049e128997--
