<?xml version="1.0" encoding="UTF-8"?>
<tree_query xmlns="http://ufal.mff.cuni.cz/pdt/pml/">
  <head>
    <schema href="tree_query_schema.xml" />
  </head>
  <q-trees>
    <LM id="generic">
      <description>Preliminary Query</description>
      <q-nodes>
        <node>
          <name>n1</name>
          <node-type>a-node</node-type>
          <overlapping>0</overlapping>
          <q-children>
            <test operator="!~">
              <a>m/lemma</a>
              <b>".Reconstructed"</b>
            </test>
            <test operator="=">
              <a>afun</a>
              <b>"Pnom"</b>
            </test>
            <node>
              <name>n0</name>
              <node-type>a-node</node-type>
              <overlapping>0</overlapping>
              <relation>
                <parent label="parent"/>
              </relation>
              <q-children>
                <test operator="~">
                  <a>m/lemma</a>
                  <b>".Reconstructed"</b>
                </test>
                <node>
                  <name>nS</name>
                  <node-type>a-root</node-type>
                  <overlapping>0</overlapping>
                  <relation>
                    <ancestor label="ancestor"/>
                  </relation>
                </node>
              </q-children>
            </node>
          </q-children>
        </node>
      </q-nodes>
    </LM>
    <LM id="general-einai">
      <q-nodes>
        <node>
          <name>n1</name>
          <node-type>a-node</node-type>
          <overlapping>0</overlapping>
          <q-children>
            <test operator="!~">
              <a>m/lemma</a>
              <b>".Reconstructed"</b>
            </test>
            <test operator="=">
              <a>afun</a>
              <b>"Pnom"</b>
            </test>
            <node>
              <name>n0</name>
              <node-type>a-node</node-type>
              <overlapping>0</overlapping>
              <relation>
                <parent label="parent"/>
              </relation>
              <q-children>
                <test operator="~">
                  <a>m/lemma</a>
                  <b>"εἰμί[0-9]*"</b>
                </test>
                <node>
                  <name>nS</name>
                  <node-type>a-root</node-type>
                  <overlapping>0</overlapping>
                  <relation>
                    <ancestor label="ancestor"/>
                  </relation>
                </node>
              </q-children>
            </node>
          </q-children>
        </node>
      </q-nodes>
    </LM>
    <LM id="GeneralSample">
      <description>Extract the general sample</description>
      <q-nodes>
        <node>
          <name>n1</name>
          <node-type>a-node</node-type>
          <overlapping>0</overlapping>
          <q-children>
            <test operator="!~">
              <a>m/lemma</a>
              <b>".Reconstructed"</b>
            </test>
            <test operator="=">
              <a>afun</a>
              <b>"Pnom"</b>
            </test>
            <node>
              <name>n0</name>
              <node-type>a-node</node-type>
              <overlapping>0</overlapping>
              <relation>
                <parent label="parent"/>
              </relation>
              <q-children>
                <test operator="~">
                  <a>m/lemma</a>
                  <b>"(εἰμί|.Reconstructed)"</b>
                </test>
                <node>
                  <name>nS</name>
                  <node-type>a-root</node-type>
                  <overlapping>0</overlapping>
                  <relation>
                    <ancestor label="ancestor"/>
                  </relation>
                </node>
              </q-children>
            </node>
          </q-children>
        </node>
      </q-nodes>
    </LM>
    <LM id="generic-coord-naif">
      <q-nodes>
        <node>
          <name>n1</name>
          <node-type>a-node</node-type>
          <overlapping>0</overlapping>
          <q-children>
            <test operator="!~">
              <a>m/lemma</a>
              <b>".Reconstructed"</b>
            </test>
            <test operator="=">
              <a>afun</a>
              <b>"Pnom"</b>
            </test>
            <node>
              <name>n0</name>
              <node-type>a-node</node-type>
              <overlapping>0</overlapping>
              <relation>
                <parent label="parent"/>
              </relation>
              <q-children>
                <test operator="=">
                  <a>is_member</a>
                  <b>1</b>
                </test>
                <test operator="~">
                  <a>m/lemma</a>
                  <b>".Reconstructed"</b>
                </test>
              </q-children>
            </node>
          </q-children>
        </node>
      </q-nodes>
    </LM>
    <LM id="non-coord">
      <description>This is  how you query for non-coordinated heads</description>
      <q-nodes>
        <node>
          <name>n1</name>
          <node-type>a-node</node-type>
          <overlapping>0</overlapping>
          <q-children>
            <test operator="!~">
              <a>m/lemma</a>
              <b>".Reconstructed"</b>
            </test>
            <test operator="=">
              <a>afun</a>
              <b>"Pnom"</b>
            </test>
            <node>
              <name>n0</name>
              <node-type>a-node</node-type>
              <overlapping>0</overlapping>
              <relation>
                <parent label="parent"/>
              </relation>
              <q-children>
                <not>
                  <test operator="=">
                    <a>is_member</a>
                    <b>1</b>
                  </test>
                </not>
                <test operator="~">
                  <a>m/lemma</a>
                  <b>".Reconstructed"</b>
                </test>
              </q-children>
            </node>
          </q-children>
        </node>
      </q-nodes>
    </LM>
    <LM id="gapping">
      <q-nodes>
        <node>
          <name>n1</name>
          <node-type>a-node</node-type>
          <overlapping>0</overlapping>
          <q-children>
            <test operator="!~">
              <a>m/lemma</a>
              <b>".Reconstructed"</b>
            </test>
            <test operator="=">
              <a>afun</a>
              <b>"Pnom"</b>
            </test>
            <node>
              <name>n0</name>
              <node-type>a-node</node-type>
              <overlapping>0</overlapping>
              <relation>
                <parent label="parent"/>
              </relation>
              <q-children>
                <test operator="=">
                  <a>is_member</a>
                  <b>1</b>
                </test>
                <test operator="~">
                  <a>m/lemma</a>
                  <b>".Reconstructed"</b>
                </test>
                <node>
                  <name>n3</name>
                  <node-type>a-node</node-type>
                  <overlapping>0</overlapping>
                  <relation>
                    <parent label="parent"/>
                  </relation>
                  <q-children>
                    <test operator="=">
                      <a>afun</a>
                      <b>"Coord"</b>
                    </test>
                    <node>
                      <name>n4</name>
                      <node-type>a-node</node-type>
                      <overlapping>0</overlapping>
                      <relation>
                        <child/>
                      </relation>
                      <q-children>
                        <test operator="~">
                          <a>m/lemma</a>
                          <b>"εἰμί[0-9]*"</b>
                        </test>
                        <test operator="=">
                          <a>is_member</a>
                          <b>1</b>
                        </test>
                      </q-children>
                    </node>
                  </q-children>
                </node>
              </q-children>
            </node>
            <node>
              <name>nS</name>
              <node-type>a-root</node-type>
              <overlapping>0</overlapping>
              <relation>
                <ancestor label="ancestor"/>
              </relation>
            </node>
          </q-children>
        </node>
      </q-nodes>
    </LM>
    <LM id="Pnom-Comprehensive">
      <description>Assess the general status of pnom</description>
      <q-nodes>
        <node>
          <name>n1</name>
          <node-type>a-node</node-type>
          <overlapping>0</overlapping>
          <q-children>
            <test operator="!~">
              <a>m/lemma</a>
              <b>".Reconstructed"</b>
            </test>
            <test operator="=">
              <a>afun</a>
              <b>"Pnom"</b>
            </test>
            <node>
              <name>n0</name>
              <node-type>a-node</node-type>
              <overlapping>0</overlapping>
              <relation>
                <parent label="parent"/>
              </relation>
              <q-children>
                <test operator="~">
                  <a>m/tag</a>
                  <b>"^v"</b>
                </test>
                <node>
                  <name>nS</name>
                  <node-type>a-root</node-type>
                  <overlapping>0</overlapping>
                  <relation>
                    <ancestor label="ancestor"/>
                  </relation>
                </node>
              </q-children>
            </node>
          </q-children>
        </node>
      </q-nodes>
      <output-filters>
        <LM>
          <distinct>0</distinct>
          <return>$n0.afun</return>
        </LM>
        <LM>
          <distinct>0</distinct>
          <return>
            <LM>$1</LM>
            <LM>count()</LM>
          </return>
          <group-by>$1</group-by>
          <sort-by>$2 desc</sort-by>
        </LM>
      </output-filters>
    </LM>
    <LM id="VerbMoodTens">
      <q-nodes>
        <node>
          <name>n1</name>
          <node-type>a-node</node-type>
          <overlapping>0</overlapping>
          <q-children>
            <test operator="!~">
              <a>m/lemma</a>
              <b>".Reconstructed"</b>
            </test>
            <test operator="=">
              <a>afun</a>
              <b>"Pnom"</b>
            </test>
            <node>
              <name>n0</name>
              <node-type>a-node</node-type>
              <overlapping>0</overlapping>
              <relation>
                <parent label="parent"/>
              </relation>
              <q-children>
                <test operator="~">
                  <a>m/tag</a>
                  <b>"^v3[sp][^p]i"</b>
                </test>
                <test operator="~">
                  <a>m/lemma</a>
                  <b>"(εἰμί[0-9]*|γίγνομαι[0-9]*|καλέω[0-9]*|πέλω[0-9]*|φαίνω[0-9]*)"</b>
                </test>
                <node>
                  <name>nS</name>
                  <node-type>a-root</node-type>
                  <overlapping>0</overlapping>
                  <relation>
                    <ancestor label="ancestor"/>
                  </relation>
                </node>
              </q-children>
            </node>
          </q-children>
        </node>
      </q-nodes>
    </LM>
    <LM id="SyntFunct">
      <q-nodes>
        <node>
          <name>n1</name>
          <node-type>a-node</node-type>
          <overlapping>0</overlapping>
          <q-children>
            <test operator="!~">
              <a>m/lemma</a>
              <b>".Reconstructed"</b>
            </test>
            <test operator="=">
              <a>afun</a>
              <b>"Pnom"</b>
            </test>
            <node>
              <name>n0</name>
              <node-type>a-node</node-type>
              <overlapping>0</overlapping>
              <relation>
                <parent label="parent"/>
              </relation>
              <q-children>
                <test operator="~">
                  <a>m/lemma</a>
                  <b>".Reconstructed"</b>
                </test>
                <node>
                  <name>nS</name>
                  <node-type>a-root</node-type>
                  <overlapping>0</overlapping>
                  <relation>
                    <ancestor label="ancestor"/>
                  </relation>
                </node>
              </q-children>
            </node>
          </q-children>
        </node>
      </q-nodes>
      <output-filters>
        <LM>
          <distinct>0</distinct>
          <return>$n0.afun</return>
        </LM>
        <LM>
          <distinct>0</distinct>
          <return>
            <LM>$1</LM>
            <LM>count()</LM>
          </return>
          <group-by>$1</group-by>
          <sort-by>$2 desc</sort-by>
        </LM>
      </output-filters>
    </LM>
    <LM id="q-16-08-04_180356">
    </LM>
  </q-trees>
</tree_query>
